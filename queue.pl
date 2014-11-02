:- module(queue, [empty_queue/1,
		  enqueue/3,
		  dequeue/3,
		  member_queue/2,
		  add_list_to_queue/3]).

empty_queue([]).

enqueue(E, [], [E]).
enqueue(E, [H|T], [H|Tnew]) :-
    enqueue(E, T, Tnew).

dequeue(E, [E|T], T).
dequeue(E, [E|_], _).

member_queue(Element, Queue) :-
    member(Element, Queue).

add_list_to_queue(List, Queue, Newqueue) :-
    append(Queue, List, Newqueue).
