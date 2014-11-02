/*
From Ch 3 of Luger and Stubblefield "AI Algroithms, Data Structures and Idioms in Prolog, Lisp, and Java"
*/

:- module(stack, [empty_stack/1,
		  stack/3,
		  member_stack/2,
		  add_list_to_stack/3,
		  reverse_print_stack/1]).

empty_stack([ ]).
stack(Top, Stack, [Top | Stack]).
member_stack(Element, Stack) :- member(Element, Stack).
add_list_to_stack(List, Stack, Result) :- append(List, Stack, Result).
reverse_print_stack(S) :- empty_stack(S).
reverse_print_stack(S) :- stack(E, Rest, S),
			  reverse_print_stack(Rest),
			  write(E), nl.
