:- module(bfs, [bfs_path/3,
		bfs_go/2,
	        moves/4,
		get_children/4]).

:- use_module('set.pl').
:- use_module('queue.pl').

bfs_path(Open_queue, _, _) :-
    empty_queue(Open_queue),
    write('Graph searched, no solution found.').
bfs_path(Open_queue, Closed_set, Goal) :-
    dequeue([State, Parent], Open_queue, _),
    State = Goal,
    write('Solution path is: '), nl,
    printsolution([State, Parent], Closed_set).
bfs_path(Open_queue, Closed_set, Goal) :-
    dequeue([State, Parent], Open_queue, Rest_open_queue),
    get_children(State, Rest_open_queue, Closed_set, Children),
    add_list_to_queue(Children, Rest_open_queue, New_open_queue),
    union([[State, Parent]], Closed_set, New_closed_set),
    bfs_path(New_open_queue, New_closed_set, Goal), !.

get_children(State, Rest_open_queue, Closed_set, Children) :-
    bagof(Child, moves(State, Rest_open_queue, Closed_set, Child), Children);
    Children = [].

moves(State, Rest_open_queue, Closed_set, [Next, State]) :-
    move(State, Next),
    not(unsafe(Next)),
    not(member_queue([Next,_], Rest_open_queue)),
    not(member_set([Next, _], Closed_set)).

bfs_go(Start, Goal) :-
    empty_queue(Empty_open_queue),
    enqueue([Start, nil], Empty_open_queue, Open_queue),
    empty_set(Closed_set),
    bfs_path(Open_queue, Closed_set, Goal).

printsolution([State, nil], _) :- write(State), nl.
printsolution([State, Parent], Closed_set) :-
    member_set([Parent, Grandparent], Closed_set),
    printsolution([Parent, Grandparent], Closed_set),
    write(State), nl.
