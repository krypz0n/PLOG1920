%final:
%aluno(Nome, [[Cadeira1],[Cadeira2]]).
%cadeira(Nome,NHorasSemanaisIndividual,[[IDTrab1,NHorasSemanais,DataInicio,DataEntrega],[IDTrab2,NHorasSemanais,DataInicio,DataEntrega]]).

%falta colocar n de semanas e uma lista de espaço de horas por aluno

%inicial:
aluno(Nome, [[Cadeira1],[Cadeira2]]).

plano_estudo_dia(NomeAluno,[[0,NomeCadeira1],[0,NomeCadeira2],[0,NomeCadeira3],[0,NomeCadeira4],[0,NomeCadeira5],
    [0,NomeCadeira6],[0,NomeCadeira7],[0,NomeCadeira8],[0,NomeCadeira9],[0,NomeCadeira10]]). %cada espaço representa n de horas de estudo seguido do nome da cadeira a estudar
plano_estudo_semana(NomeALuno,[[PlanoDia1],[PlanoDia2],[PlanoDia3],[PlanoDia4],[PlanoDia5],[PlanoDia6]]). % PlanoDia representa uma variavel do tipo plano_estudo_dia

cadeira(Nome,NHorasSemanaisIndividual).

%lista alunos INPUT?:
alunos([asdrubal,felismina]).
%alunos:
aluno(asdrubal, [[esof],[rcom]]).
aluno(feslismina, [[esof]]).

%cadeiras:
cadeira(esof,3).
cadeira(rcom,2).

