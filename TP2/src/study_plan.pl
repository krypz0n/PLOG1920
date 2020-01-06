:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(samsort)).
:- use_module(library(random)).

:- consult('inputs.pl').
:- consult('tools.pl').
:- consult('display.pl').

test(Nome,Turma,[[Cadeira1],[Cadeira2]]).

test(nigga,test,[[rcom],[esof]]).

study :-
    display_intro,
    write('1 - Manual Input'), nl,
    write('2 - Generate Data'), nl,
    read(Option),
    (
        (Option = 1, manual_input(StudentList,NoStudents,ClassList,ClassNo));
        (Option = 2, write('working on it')) 
    ), !.



%etapas:
%– Declaração de variáveis e seus domínios
%– Declaração de restrições sobre as variáveis
%– Pesquisa de uma solução
