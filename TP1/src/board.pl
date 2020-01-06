
% initial game board, Blue = 1; Red = 2; empty = 0;
board_start([
[1,0,0,0,0,0,2],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[2,0,0,0,0,0,1]]).

/************************************************
			DISPLAY BOARD					
************************************************/

%imprime board

print_board(Board) :-
	nl,nl, write('    1 | 2 | 3 | 4 | 5 | 6 | 7 '), nl,
	write('  |---------------------------|'),nl,
	print_matrix(Board,1).


%imprime matriz linha a linha
print_matrix([], 8). 
print_matrix([Head|Tail], N) :-
    write(N),
    N1 is N + 1,
    write(' |'),
    show_line(Head),nl,
	write('  |---------------------------|'),nl,
    print_matrix(Tail, N1).
	
% imprime recursivamente os caracteres de cada linha do tabuleiro
show_line([]).
show_line([Head|Tail]):-
	translate(Head),
	write('|'),
	show_line(Tail).
	


