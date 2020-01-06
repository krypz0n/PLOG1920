% Translates the value of the cell to be printed

translate(0):- write(' ').
translate(1):- write(' B').
translate(2):- write(' R').

% reads user input
reads(Input):-
    get_code(Ch),
	readsAll(Ch,[H|T]),
	name(Linha,[H|T]), !.

readsAll(13,[]).
readsAll(10,[]).

readsAll(Ch,[Ch|Chars]):-
	Ch >= 48,
	Ch =< 57,
	!,
	get_code(NewCh),
	readsAll(NewCh,Chars).

% verifies if the cell is empty
isEmpty(0).

% verifies if the position is inside the board
isInBoard([First|Rest], Line, Col):-
    Line > 0,
    Col > 0,
    length([First|Rest], BSize),
    Line < BSize,
    length(First, LLength),
    Col < LLength.


% to read coordinates from the user
getNum(N):-
	get_code(C),
	get_char(_),
    N is C - 48.

getNum(13,[]).
getNum(10,[]).

player1(1).
player2(2).