:- dynamic(score/2).
:- dynamic(prob/2).

% =========================
% INITIALIZATION
% =========================

init_scores :-
    retractall(score(_,_)),
    assertz(score(e,0)), assertz(score(i,0)),
    assertz(score(s,0)), assertz(score(n,0)),
    assertz(score(t,0)), assertz(score(f,0)),
    assertz(score(j,0)), assertz(score(p,0)).

init_probabilities :-
    retractall(prob(_,_)),
    init_prob_list([intj,intp,entj,entp,infj,infp,enfj,enfp,
                    istj,isfj,estj,esfj,istp,isfp,estp,esfp]).

init_prob_list([]).
init_prob_list([H|T]) :-
    assertz(prob(H, 0.0625)),
    init_prob_list(T).

init :-
    init_scores,
    init_probabilities.

% =========================
% WEIGHT SYSTEM
% =========================

weight(1,  2).
weight(2,  1).
weight(3,  0).
weight(4, -1).
weight(5, -2).

% =========================
% SCORE UPDATE
% =========================

update_score(_Dim, Dir, Ans) :-
    weight(Ans, W),
    score(Dir, Old),
    New is Old + W,
    retract(score(Dir, Old)),
    assertz(score(Dir, New)).

% =========================
% PROBABILITY UPDATE
% =========================

update_probabilities(Dim, Dir, Ans) :-
    weight(Ans, W),
    findall(Type-P, prob(Type,P), List),
    update_prob_list(List, Dim, Dir, W),
    normalize.

update_prob_list([], _, _, _).
update_prob_list([Type-P|T], Dim, Dir, W) :-
    matches(Type, Dim, Dir, Match),
    update_single_prob(P, Match, W, NewP),
    retractall(prob(Type, _)),   % 🔥 safer
    assertz(prob(Type, NewP)),
    update_prob_list(T, Dim, Dir, W).

update_single_prob(P, yes, W, NewP) :-
    Factor is 1 + 0.25 * W,
    NewP is P * Factor.

update_single_prob(P, no, W, NewP) :-
    Factor is 1 - 0.25 * W,
    NewP is P * Factor.

% =========================
% NORMALIZATION
% =========================

normalize :-
    findall(P, prob(_,P), Ps),
    sum_list(Ps, Sum),
    (Sum =:= 0 -> reset_uniform ; normalize_all(Sum)).

normalize_all(Sum) :-
    findall(Type-P, prob(Type,P), List),
    normalize_list(List, Sum).

normalize_list([], _).
normalize_list([Type-P|T], Sum) :-
    NewP is P / Sum,
    retractall(prob(Type, _)),   % 🔥 safer
    assertz(prob(Type, NewP)),
    normalize_list(T, Sum).

reset_uniform :-
    init_probabilities.

% =========================
% COMBINED UPDATE
% =========================

process_answer(Dim, Dir, Ans) :-
    update_score(Dim, Dir, Ans),
    update_probabilities(Dim, Dir, Ans).

% =========================
% BEST TYPE
% =========================

best_type(Type) :-
    findall(P-T, prob(T,P), List),
    max_pair(List, _-Type).

max_pair([H], H).
max_pair([P1-T1|T], Max) :-
    max_pair(T, P2-T2),
    (P1 >= P2 -> Max = P1-T1 ; Max = P2-T2).

% =========================
% CONFIDENCE
% =========================

max_confidence(Max) :-
    findall(P, prob(_,P), Ps),
    max_list(Ps, Max).

% =========================
% TOP K
% =========================

top_k(K, List) :-
    findall(P-T, prob(T,P), All),
    take_k(K, All, List).

take_k(0, _, []) :- !.
take_k(_, [], []) :- !.
take_k(K, List, [Max|Rest]) :-
    max_pair(List, Max),
    remove(Max, List, NewList),
    K1 is K - 1,
    take_k(K1, NewList, Rest).

remove(_, [], []).
remove(X, [X|T], T) :- !.
remove(X, [H|T], [H|R]) :-
    remove(X, T, R).

% =========================
% FINAL TYPE
% =========================

final_type(Type) :-
    score(e,E), score(i,I),
    score(s,S), score(n,N),
    score(t,Tv), score(f,F),
    score(j,J), score(p,P),

    (E >= I -> EI = e ; EI = i),
    (S >= N -> SN = s ; SN = n),
    (Tv >= F -> TF = t ; TF = f),
    (J >= P -> JP = j ; JP = p),

    atom_concat(EI, SN, T1),
    atom_concat(T1, TF, T2),
    atom_concat(T2, JP, Type).

% =========================
% STOP CONDITION
% =========================

should_stop :-
    max_confidence(Max),
    Max >= 0.75.

% =========================
% OUTPUT
% =========================

print_top(K) :-
    top_k(K, List),
    write('Top matches:'), nl,
    print_probs(List).

print_probs([]).
print_probs([P-T|Rest]) :-
    Percent is P * 100,
    write(T), write(' : '), write(Percent), write('%'), nl,
    print_probs(Rest).