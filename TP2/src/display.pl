:- use_module(library(lists)).

display_timetable([],_).
display_timetable([Head|Tail],Index) :-
    write('Student #:'), write(Index),
    IndexAux is Index + 1,
    display_timetable(Tail,Index).
    