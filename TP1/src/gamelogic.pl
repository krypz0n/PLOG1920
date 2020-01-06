:- ensure_loaded('utils.pl').

% returns the Element(Line or ) on the given position
getElemInPos(1, [Element|_], Element).
getElemInPos(Pos, [_|Rest], Element):-
    Pos > 1,
    Next is Pos-1,
    getElemInPos(Next, Rest, Element).

% gets the piece in a given position 
getPiece(Board, Line, Column, Piece):-
    getElemInPos(Line, Board, LineElem),
    getElemInPos(Column, LineElem, Piece).

% verifies if a cell in a given position is empty
isCellEmpty(Board, Line, Col):-
    getPiece(Board, Line, Col, Piece),
    isEmpty(Piece).

% verifies if the piece belongs to player
cellBelongsPlayer(Board, Line, Col, Player):-
    getPiece(Board, Line, Col, Piece),
    Piece == Player.


% verifies if the position chosen is adjacent to the last position of the player 
% right
isAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col+1,
    NewLine =:= Line.

% left
isAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col-1,
    NewLine =:= Line.

% up
isAdjacent(Line, Col, NewLine, NewCol):-
    NewLine =:= Line-1,
    NewCol =:= Col.

% down
isAdjacent(Line, Col, NewLine, NewCol):-
    NewLine =:= Line+1,
    NewCol =:= Col.

% diagonal right-up
isAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col+1,
    NewLine =:= Line-1.

% diagonal right-down
isAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col+1,
    NewLine =:= Line+1.

% diagonal left-up
isAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col-1,
    NewLine =:= Line-1.

% diagonal left-down
isAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col-1,
    NewLine =:= Line+1.


% verifies if the position chosen is two spaces away from a piece that belongs to the player 
% right
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col+2,
    NewLine =:= Line.

% left
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col-2,
    NewLine =:= Line.

% up
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewLine =:= Line-2,
    NewCol =:= Col.

% down
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewLine =:= Line+2,
    NewCol =:= Col.

% diagonal left-down
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col+2,
    NewLine =:= Line-2.

% diagonal left-up
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col+2,
    NewLine =:= Line+2.

% diagonal right-down
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col-2,
    NewLine =:= Line-2.

% diagonal right-up
isSecondAdjacent(Line, Col, NewLine, NewCol):-
    NewCol =:= Col-2,
    NewLine =:= Line+2.

% returns coordinates of adjacent cell

findAdjacentCell(Line, Col, ALine, ACol, 1):-
    Col > 1,
    ACol is Col-1,
    ALine is Line.

findAdjacentCell(Line, Col, ALine, ACol, 2):-
    Col < 7,
    ACol is Col+1,
    ALine is Line.

findAdjacentCell(Line, Col, ALine, ACol, 3):-
    Line > 1,
    ALine is Line-1,
    ACol is Col.

findAdjacentCell(Line, Col, ALine, ACol, 4):-
    Line < 7,
    ALine is Line+1,
    ACol is Col.

findAdjacentCell(Line, Col, ALine, ACol, 5):-
    Line > 1,
    Col < 7,
    ACol is Col+1,
    ALine is Line-1.

findAdjacentCell(Line, Col, ALine, ACol, 6):-
    Line < 7,
    Col < 7,
    ACol is Col+1,
    ALine is Line+1.

findAdjacentCell(Line, Col, ALine, ACol, 7):-
    Line > 1,
    Col > 1,
    ACol is Col-1,
    ALine is Line-1.

findAdjacentCell(Line, Col, ALine, ACol, 8):-
    Line > 7,
    Col > 1,
    ACol is Col-1,
    ALine is Line+1.



% verifies if the move is valid 
isMoveValid(Board, Line, Col, NewLine, NewCol, Adj):-
    isInBoard(Board, NewLine, NewCol),
    isCellEmpty(Board, NewLine, NewCol),
    isAdjacent(Line, Col, NewLine, NewCol),
    Adj is 1.

isMoveValid(Board, Line, Col, NewLine, NewCol, Adj):-
    isInBoard(Board, NewLine, NewCol),
    isCellEmpty(Board, NewLine, NewCol),
    isSecondAdjacent(Line, Col, NewLine, NewCol),
    Adj is 2.

% inserts piece in the Column specified for the given Line
insertInColumn([_|Rest], 1, Player, [Player|Rest]).

insertInColumn([First|Rest], Col, Player, [First|NewLine]):-
    Col>1,
    Next is Col-1,
    insertInColumn(Rest, Next, Player, NewLine).

% inserts piece in the Line and Column specified 
insertInLine([Line|_], 1, Col, Player, [NewLine|Rest]):-
    insertInColumn(Line, Col, Player, NewLine).
insertInLine([First|Rest], Line, Col, Player, [First|New]):-
    Line>1,
    Next is Line-1,
    insertInLine(Rest, Next, Player, New).


% insert a piece in the given position, after verifying if the move is valid for adjacent position
insertPiece(Board, Player, Line, Col, NewLine, NewCol, NewBoard):-
    isMoveValid(Board, Line, Col, NewLine, NewCol, Adj),
    Adj == 1,
    insertInLine(Board, NewLine, NewCol, Player, NewBoard).

% insert a piece in the given position, after verifying if the move is valid for non-adjacent position
insertPiece(Board, Player, Line, Col, NewLine, NewCol, NewBoard):-
    isMoveValid(Board, Line, Col, NewLine, NewCol, Adj),
    Adj == 2,
    insertInLine(Board, NewLine, NewCol, Player, NewBoard),
    insertInLine(Board, Line, Col, 0, NewBoard).

% reads the position chosen by the player
askMove(Board, Line, Col, Player):-
    write('Where do you want to place the next microbe?'), nl,
    write('Line (Between 1 and 7): '), getNum(Line), 
    write('Column (Between 1 and 7): '), getNum(Col), nl. 

% makes the move specified by the player
makeMove(Board, Line, Col, Player, NewBoard):-
    askMove(Board, NewLine, NewCol, Player),
    insertPiece(Board, Player, Line, Col, NewLine, NewCol, NewBoard),
    turnColour(Board, NewLine, NewCol, Player, NewBoard).

%makes the color switch
switchEnemyPiece(Board, Player, Enemie, Line, Col, 8).

switchEnemyPiece(Board, Player, Enemie, Line, Col, N):-
    findAdjacentCell(Line, Col, ALine, ACol, N),
    %cellBelongsPlayer(Board, ALine, ACol, Enemie),
    getPiece(Board, ALine, ACol, Piece),
    Piece == Enemie,
    insertInLine(Board, ALine, ACol, Player, NewBoard),
    Next is N+1,
    Next <= 8,
    switchEnemyPiece(Board, Player, Enemie, Line, Col, Next).

switchEnemyPiece(Board, Player, Enemie, Line, Col, N):-
    findAdjacentCell(Line, Col, ALine, ACol, N),
    %cellBelongsPlayer(Board, ALine, ACol, Enemie),
    getPiece(Board, ALine, ACol, Piece),
    Piece == 0,
    Next is N+1,
    Next <= 8,
    switchEnemyPiece(Board, Player, Enemie, Line, Col, Next).

switchEnemyPiece(Board, Player, Enemie, Line, Col, N):-
    findAdjacentCell(Line, Col, ALine, ACol, N),
    %cellBelongsPlayer(Board, ALine, ACol, Enemie),
    getPiece(Board, ALine, ACol, Piece),
    Piece == Player,
    Next is N+1,
    Next <= 8,
    switchEnemyPiece(Board, Player, Enemie, Line, Col, Next).

switchEnemyPiece(Board, Player, Enemie, Line, Col, N):-
    \+findAdjacentCell(Line, Col, ALine, ACol, N),
    Next is N+1,
    Next <= 8,
    switchEnemyPiece(Board, Player, Enemie, Line, Col, Next).

% calculates the pieces that change colour
turnColour(Board, Line, Col, Player, NewBoard):-
    player1(Player),
    player2(Enemie),
    switchEnemyPiece(Board, Player, Enemie, Line, Col, 1).
    

turnColour(Board, Line, Col, Player, NewBoard):-
    player2(Player),
    player1(Enemie),
    switchEnemyPiece(Board, Player, Enemie, Line, Col, 1).

findEmptyCell([],_,_,[]).
findEmptyCell(Board, Line, Col, CoordinatesList). %incomplete

	
validMoves([Head|Tail], Player, ListOfMoves):-
	findEmptyCell([Head|Tail], Line, Col, ListOfMoves). %incomplete
