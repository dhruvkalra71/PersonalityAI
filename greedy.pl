:- dynamic(asked/1).

% =========================
% EXPECTED INFORMATION SCORE
% =========================

expected_score(Dim, Dir, Score) :-
    findall(P,
        (prob(T, P), matches(T, Dim, Dir, yes)),
        YesList),
    sum_list(YesList, YesProb),

    NoProb is 1 - YesProb,

    Diff is YesProb - NoProb,
    AbsDiff is abs(Diff),

    Score is 1 - AbsDiff.

% =========================
% DIMENSION RESOLUTION (PRUNING)
% =========================

dimension_resolved(Dim) :-
    findall(P,
        (prob(T, P), matches(T, Dim, _, yes)),
        Ps),
    sum_list(Ps, Sum),
    (Sum >= 0.85 ; Sum =< 0.15).

% =========================
% CHECK IF QUESTION IS USEFUL
% =========================

useful_question(QID) :-
    question(QID, _, Dim, _),
    \+ dimension_resolved(Dim),
    \+ asked(QID).

% =========================
% BEST QUESTION (SAFE)
% =========================

best_question(QID, Text) :-
    findall(Score-Q-Txt,
        (
            question(Q, Txt, Dim, Dir),
            useful_question(Q),
            expected_score(Dim, Dir, Score)
        ),
        List),
    List \= [],
    max_in_list(List, _-QID-Text).

% =========================
% FIND MAX
% =========================

max_in_list([H], H).
max_in_list([H|T], Max) :-
    max_in_list(T, TempMax),
    compare_score(H, TempMax, Max).

compare_score(S1-_-_, S2-_-_, S1-_-_) :-
    S1 >= S2, !.
compare_score(_, S2-_-_, S2-_-_).

% =========================
% FALLBACK
% =========================

fallback_question(QID, Text) :-
    question(QID, Text, _, _),
    \+ asked(QID),
    !.

% =========================
% NEXT QUESTION
% =========================

next_question(QID, Text) :-
    best_question(QID, Text), !.

next_question(QID, Text) :-
    fallback_question(QID, Text).

% =========================
% MARK QUESTION ASKED
% =========================

mark_asked(QID) :-
    assertz(asked(QID)).

% =========================
% RESET
% =========================

reset_questions :-
    retractall(asked(_)).

% =========================
% DEBUG
% =========================

top_questions :-
    findall(Score-Q,
        (
            question(Q, _, Dim, Dir),
            \+ asked(Q),
            expected_score(Dim, Dir, Score)
        ),
        List),

    write('Candidate questions with scores:'), nl,
    print_q(List).

print_q([]).
print_q([Score-Q|Rest]) :-
    write(Q), write(' -> '), write(Score), nl,
    print_q(Rest).