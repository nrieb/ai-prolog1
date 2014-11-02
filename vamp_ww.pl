:- use_module('stack.pl').
:- use_module('bfs.pl').

opp(e, w).
opp(w, e).

move_n_to(e, Val, New_val, N) :-
    New_val is Val - N.

move_n_to(w, Val, New_val, N) :-
    New_val is Val + N.    

max_size(3).

writelist([]) :- nl.
writelist([H|T]) :- write(H), write(' '), writelist(T).

move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, WWs_west)) :-
    opp(X, Y),
    move_n_to(Y, Vamps_west, New_vamps, 2),
    max_size(Max),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, WWs_west)]).

move(state(X, Vamps_west, WWs_west),
     state(Y, Vamps_west, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 2),
    max_size(Max),
    between(0, Max, New_wws),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, Vamps_west, New_wws)]).

move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 1),
    max_size(Max),
    between(0, Max, New_wws),
    move_n_to(Y, Vamps_west, New_vamps, 1),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, New_wws)]).

move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, WWs_west)) :-
    opp(X, Y),
    move_n_to(Y, Vamps_west, New_vamps, 1),
    max_size(Max),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, WWs_west)]).

move(state(X, Vamps_west, WWs_west),
     state(Y, Vamps_west, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 1),
    max_size(Max),
    between(0, Max, New_wws),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, Vamps_west, New_wws)]).

move(state(X, V, WW), state(X, V, WW)) :-
    writelist(['BACKTRACK at:', X, V, WW]), fail.

unsafe(state(_, Vamps_west, WWs_west)) :-
    Vamps_west > 0,
    WWs_west > Vamps_west.

unsafe(state(_, Vamps_west, WWs_west)) :-
    max_size(Max),
    Vamps_east is Max - Vamps_west,
    WWs_east is Max - WWs_west,
    Vamps_east > 0,
    WWs_east > Vamps_east.

path(Goal, Goal, Been_stack) :-
    write('Solution Path Is: '), nl,
    reverse_print_stack(Been_stack).
path(State, Goal, Been_stack) :-
    move(State, Next_state),
    not(member_stack(Next_state, Been_stack)),
    stack(Next_state, Been_stack, New_been_stack),
    path(Next_state, Goal, New_been_stack), !.

go(Start, Goal) :-
    empty_stack(Empty_been_stack),
    stack(Start, Empty_been_stack, Been_stack),
    path(Start, Goal, Been_stack).

test :- go(state(e, 0, 0), state(w, 3, 3)).
test1 :- go(state(e, 0, 0), state(w, 0, 1)).
bfs_test :- bfs_go(state(e, 0, 0), state(w, 3, 3)).
bfs_test1 :- bfs_go(state(e, 0, 0), state(w, 0, 1)).
