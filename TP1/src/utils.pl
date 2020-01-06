% Para traduzir os caracteres do tabuleiro

translate(0):- write(' . ').
translate(1):- write(' B ').
translate(2):- write(' R ').

player1(2).
player2(1).

% Return biggest Bigger from Blue and Red, or if its a tie
bigger_number(Bigger,BlueCount,RedCount) :-
        RedCount>BlueCount,
        Bigger = 'Red Player has won!'.
        
bigger_number(Bigger,BlueCount,RedCount) :-
        BlueCount>RedCount,
        Bigger = 'Blue Player has won!'.

bigger_number(Bigger,BlueCount,RedCount) :-
        Bigger = 'Its a tie'.


%checks if any element X exists in passed Matrix
member_exists_in_matrix(X,[[X|_]|_]).
member_exists_in_matrix(X,[[H|T1]|T2]) :-
        member_exists_in_matrix(X,[T1|T2]).
member_exists_in_matrix(X,[[]|T2]) :-
        member_exists_in_matrix(X,T2).

%checks if any element X exists in passed Matrix
count_number_of_elements(X,[[X|T1]|T2],Count) :- %find X middle of Matrix
        count_number_of_elements(X,[T1|T2],Count2),
        Count is Count2 + 1.
count_number_of_elements(X,[[H|T1]|T2],Count) :- %dont find X middle of Matrix
        count_number_of_elements(X,[T1|T2],Count).
count_number_of_elements(X,[[]|T2],Count) :-  %reach end of a line
        count_number_of_elements(X,T2,Count). 
count_number_of_elements(X,[[]|[]],0). %reach end of matrix


%Replaces Element in Matrix [H|T] in Row, Column, with Value 
replaceElementInList([_H|T], 0, Value, [Value|T]).
replaceElementInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceElementInList(T, Index1, Value, TNew).

replaceElementInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
        replaceElementInList(H, Column, Value, HNew).

replaceElementInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
        Row > 0,
        Row1 is Row - 1,
        replaceElementInMatrix(T, Row1, Column, Value, TNew).

getElementFromList([H|_T], 0, Value) :-
        Value = H.

getElementFromList([_H|T], Index, Value) :-
        Index > 0,
        Index1 is Index - 1,
        getElementFromList(T, Index1, Value).

getElementFromMatrix([H|_T], 0, Column, Value) :-
        getElementFromList(H, Column, Value).

getElementFromMatrix([_H|T], Row, Column, Value) :-
        Row > 0,
        Row1 is Row - 1,
        getElementFromMatrix(T, Row1, Column, Value).


% reads user input ADDED
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