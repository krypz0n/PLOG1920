:- consult('board.pl').
:- consult('game.pl').
:- consult('gamelogic.pl').
:- consult('menu.pl').
:- consult('utils.pl').
:- consult('test.pl').

infection :-
	display_menu.


teste:-
	%startGame.
	board_start(Board_Initial),
	%insertPiece(Board_Initial, 2, 1, 7, 1, 6, NewBoard),
	print_board(NewBoard).

