show_list_elements([]) :-
    nl.
show_list_elements([A|B]) :-
  write(' '),write(A),write(' '),
  show_list_elements(B).

reset_timer :- statistics(walltime,_).	
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.