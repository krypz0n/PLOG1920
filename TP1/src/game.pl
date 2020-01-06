%begins game and calls for start of loop
start_game(Player1,Player2) :-
	board_End_Full1and2(Board_Initial),
	loop_game(Board_Initial,Player1,Player2).

%loops game, checking if game has ended on each play
loop_game(Board,Player1,Player2) :-
	print_board(Board),!,
	red_player_turn(Board,Player1),
	print_board(Board),!,
	blue_player_turn(Board,Player2),
	loop_game(Board,Player1,Player2).

startGame:-
	board_start(Board_Initial),
	gameLoop(Board_Initial, 2, 1).

gameLoop(Board, Player1, Player2):-
	%print_board(Board),!,
	%makeMove(Board, 1, 7, Player1, NewBoard),
	game_not_over(Player1, NewBoard),
	gameLoop(Board, Player2, Player1).

red_player_turn(Board,Player1) :-
	%write('Red player '), read(X), %makeMove(Board, Line, Col, Player, NewBoard),
	%makeMove(Board, 1, 7, Player1, NewBoard),
	game_not_over(1, NewBoard).%after red turn, check if any blue bacteria exists in board

%red_player_turn(Board,Player1) :-
%	write('red player has won!'),
%	!,fail.
blue_player_turn(Board,Player2) :-
	%write('Blue player '), read(X), %makeMove(Board, Line, Col, Player, NewBoard),
	%makeMove(Board, 1, 7, Player2, NewBoard),
	game_not_over(2, NewBoard). %after blue turn, check if any red bacteria exists in board

%calling a function with same name as the one who fails will make the failing function call this one
%blue_player_turn(Board,Player2) :-
%	write('blue player has won!'),
%	!,fail.	 %this insures program stops running.

%checks end game statuses
game_not_over(Player, Board) :- 
	member_exists_in_matrix(Player,Board), %checks if Player exists on Board, returns yes if true, no if doesnt exist
	!,check_board_is_empty(Board).

%check if board still has empty spots (0's)
check_board_is_empty(Board) :-
	member_exists_in_matrix(0,Board). %verifies if there are still open slots on board (if not, means board is full)
%count 1 and 0 and compare
check_board_is_empty(Board) :-
	count_number_of_elements(1,Board,BlueCount),
	count_number_of_elements(2,Board,RedCount),
	bigger_number(Bigger,BlueCount,RedCount), 
	format('Game has ended, ~s',[Bigger]),
	!,fail. 

true_thing :-
	2 is 1+1.

test :-
	board_start(Board1),
	print_board(Board1),
	makeMove(Board, Line, Col, Player, NewBoard),
	print_board(Board1),
	print_board(NewBoard).
