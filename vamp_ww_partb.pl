%Part b: 3 vamps, 3 werewolves, boat seats 2.  Different move ordering that part a.

:- use_module('bfs.pl').

% opposite side
opp(e, w).
opp(w, e).

% Move N things from west to east
% Val is initial value, New_val is output
move_n_to(e, Val, New_val, N) :-
    New_val is Val - N.

% Move N things from east to west
% Val is initial value, New_val is output
move_n_to(w, Val, New_val, N) :-
    New_val is Val + N.    

%Max number of things.
max_size(3).

%Output a list
writelist(_).
%writelist([]) :- nl.
%writelist([H|T]) :- write(H), write(' '), writelist(T).

% move 2 vamps over to opposite shore
move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, WWs_west)) :-
    opp(X, Y),
    move_n_to(Y, Vamps_west, New_vamps, 2),
    max_size(Max),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, WWs_west)]).

% move 2 werewolves over to opposite shore
move(state(X, Vamps_west, WWs_west),
     state(Y, Vamps_west, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 2),
    max_size(Max),
    between(0, Max, New_wws),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, Vamps_west, New_wws)]).

% move 1 vamps and 1 werewolf over to opposite shore
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

% move 1 werewolf over to opposite shore
move(state(X, Vamps_west, WWs_west),
     state(Y, Vamps_west, New_wws)) :-
    opp(X, Y),
    move_n_to(Y, WWs_west, New_wws, 1),
    max_size(Max),
    between(0, Max, New_wws),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, Vamps_west, New_wws)]).

% move 1 vamp over to opposite shore
move(state(X, Vamps_west, WWs_west),
     state(Y, New_vamps, WWs_west)) :-
    opp(X, Y),
    move_n_to(Y, Vamps_west, New_vamps, 1),
    max_size(Max),
    between(0, Max, New_vamps),
    writelist([state(X, Vamps_west, WWs_west),
	     state(Y, New_vamps, WWs_west)]).

%unsafe if werewolves outnumber vampires on the west
unsafe(state(_, Vamps_west, WWs_west)) :-
    Vamps_west > 0,
    WWs_west > Vamps_west.

%unsafe if werewolves outnumber vampires on the east
unsafe(state(_, Vamps_west, WWs_west)) :-
    max_size(Max),
    Vamps_east is Max - Vamps_west,
    WWs_east is Max - WWs_west,
    Vamps_east > 0,
    WWs_east > Vamps_east.

find :- max_size(Max), bfs_go(state(e, 0, 0), state(w, Max, Max)).
