% consult('traits.pl').
% consult('questions.pl').
% consult('personality.pl').
% consult('inference.pl').
% consult('greedy.pl').
% consult('main.pl').

:- dynamic(total_questions/1).

% =========================
% START
% =========================

start :-
    nl, write('=== Personality Test ==='), nl,
    init,
    reset_questions,
    retractall(total_questions(_)),   % 🔥 safe reset
    assertz(total_questions(0)),
    ask_loop.

% =========================
% MAIN LOOP
% =========================

ask_loop :-
    should_stop,
    !,
    nl, write('High confidence reached!'), nl,
    finalize.

ask_loop :-
    next_question(QID, Text),
    !,
    ask(QID, Text),
    increment_counter,
    ask_loop.

ask_loop :-
    nl, write('No more questions available.'), nl,
    finalize.

% =========================
% ASK QUESTION
% =========================

ask(QID, Text) :-
    nl,
    write('Q: '), write(Text), nl,
    write('1. Strongly Agree'), nl,
    write('2. Agree'), nl,
    write('3. Neutral'), nl,
    write('4. Disagree'), nl,
    write('5. Strongly Disagree'), nl,
    write('Enter choice (1-5): '),
    read(Ans),

    validate_answer(Ans),

    question(QID, _, Dim, Dir),
    process_answer(Dim, Dir, Ans),

    mark_asked(QID).

% =========================
% VALIDATION
% =========================

validate_answer(Ans) :-
    valid_option(Ans), !.

validate_answer(_) :-
    write('Invalid input. Please enter a number from 1 to 5.'), nl,
    read(NewAns),
    validate_answer(NewAns).

valid_option(1).
valid_option(2).
valid_option(3).
valid_option(4).
valid_option(5).

% =========================
% COUNTER
% =========================

increment_counter :-
    (retract(total_questions(N)) -> true ; N = 0),  % 🔥 safe fallback
    N1 is N + 1,
    assertz(total_questions(N1)).

% =========================
% FINALIZATION
% =========================

finalize :-
    nl, write('=== RESULT ==='), nl,

    % Show probabilities
    print_top(3),

    % Get best type
    best_type(Type),

    % Show personality
    personality(Type, Name, Desc, Strengths, Weaknesses),

    nl,
    write('Your Personality Type: '),
    write(Type), write(' ('), write(Name), write(')'), nl,

    nl, write('Description:'), nl,
    write(Desc), nl,

    nl, write('Strengths:'), nl,
    print_list(Strengths),

    nl, write('Weaknesses:'), nl,
    print_list(Weaknesses),

    (total_questions(Total) -> true ; Total = 0),
    nl, write('Questions Answered: '), write(Total), nl,

    nl, write('Thank you for taking the test!'), nl.

% =========================
% PRINT LIST
% =========================

print_list([]).
print_list([H|T]) :-
    write('- '), write(H), nl,
    print_list(T).