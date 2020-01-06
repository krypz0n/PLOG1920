display_menu :-
	print_menu,
	ask_input,
	process_input.

print_menu :-
	write(' _________________________________________________ '),nl,
	write('|                                                 |'),nl,
	write('|             7th Guest: Infection                |'),nl,
	write('|             1) Start Game (Player vs Player)    |'),nl,
	write('|             2) Start Game (Player vs Computer)  |'),nl,
	write('|             3) Start Game (Computer vs Computer)|'),nl,
	write('|             4) Not Implemented yet              |'),nl,
	write('|_________________________________________________|'),nl.
	
ask_input :-
	write('>Insert an option     '),nl.
	
process_input :-
	read(Input),
	menu_option(Input).
	
	
menu_option(1) :- start_game('Player','Player').
menu_option(2) :- write('Not implemented yet'),nl,display_menu.
menu_option(3) :- write('Not implemented yet'),nl,display_menu.
menu_option(4) :- write('Not implemented yet'),nl,display_menu.

menu_option(Option) :-
	Option \= 1,
	Option \= 2,
	Option \= 3,
	Option \= 4,
	write('Please insert a valid option'),nl,
	display_menu.