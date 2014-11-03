:- use_module('bfs.pl').

opp(e, w).
opp(w, e).

move_n_to(e, Val, New_val, N) :-
    New_val is Val - N.

move_n_to(w, Val, New_val, N) :-
    New_val is Val + N.    

max_size(4).

writelist([]) :- nl.
writelist([H|T]) :- write(H), write(' '), writelist(T).

move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, WWs_west)) :-
    opp(X, Y),
    move_n_to(Y, Vamps_west, New_vamps, 3),
    max_size(Max),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, WWs_west)]).

move(state(X, Vamps_west, WWs_west),
     state(Y, Vamps_west, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 3),
    max_size(Max),
    between(0, Max, New_wws),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, Vamps_west, New_wws)]).

move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 2),
    max_size(Max),
    between(0, Max, New_wws),
    move_n_to(Y, Vamps_west, New_vamps, 1),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, New_wws)]).

move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 1),
    max_size(Max),
    between(0, Max, New_wws),
    move_n_to(Y, Vamps_west, New_vamps, 2),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, New_wws)]).

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

unsafe(state(_, Vamps_west, WWs_west)) :-
    Vamps_west > 0,
    WWs_west > Vamps_west.

unsafe(state(_, Vamps_west, WWs_west)) :-
    max_size(Max),
    Vamps_east is Max - Vamps_west,
    WWs_east is Max - WWs_west,
    Vamps_east > 0,
    WWs_east > Vamps_east.

bfs_test :- max_size(Max), bfs_go(state(e, 0, 0), state(w, Max, Max)).
