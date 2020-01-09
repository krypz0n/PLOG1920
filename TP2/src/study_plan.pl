:- use_module(library(clpfd)).

:- consult('tools.pl').
%:- consult('display.pl').

%N de Horas por Trabalho por cadeira([2 trabalhos], [1 trabalho])= [[5,6],[4]]    GroupWorkHours
%Lista de Deadlines=[[10,25],[15]] GroupWorkDeadlines
%Lista de Grupos por cadeira [ [[3,5],[1,2]] ,[[],[]]] GroupWorkMembers

% main_parser(TimetableInd,TimetableGroup,2,21,2,[2,2],[[2,2],[3]],[[10,20],[15]],[[[1,2]],[[2]]]).

%main function
main_parser(TimetablesIndividual,TimetablesGroups,NoOfStudents,NoOfDays,NoOfDifferentClasses,ClassHours,GroupWorkHours,GroupWorkDeadlines,GroupWorkMembers) :- %,GroupWorkHours,GroupWorkDeadlines,GroupWorkMembers %ClassHours=[5,6,7]. 
    reset_timer,
    
    length(TimetablesIndividual,NoOfStudents), %restringe numero de elems em Timetables como NoOfStudents
    length(TimetablesGroups,NoOfStudents),
    

    timetable_day_parser(TimetablesIndividual,NoOfDifferentClasses,FlattenedIndividualTimetables,NoOfDays), %cria timetable individual a 0's
    timetable_day_parser(TimetablesGroups,NoOfDifferentClasses,FlattenedGroupTimetables,NoOfDays),  %cria timetable de grupos de trabalho
    nl,write('TIMETABLE GROUPS:'),
    nl,write(TimetablesGroups),nl,

    nl,write('TIMETABLE INDIVIDUAL:'),
    nl,write(TimetablesIndividual),nl,


    %individual_class_parser(ClassHours,TimetablesIndividual,1),                                             %preenche timetable individual com horas individuais semanais 
    %group_assignment_parser(TimetablesGroups,GroupWorkHours,GroupWorkDeadlines,GroupWorkMembers,1), %preenche timetable de grupos com horas para trabalhos de grupos

    %falta juntar timetables individuais e de grupo

    append(FlattenedIndividualTimetables,FlattenedGroupTimetables,ToBeLabelledFlatTables),

    labeling([],ToBeLabelledFlatTables),
    write('INDIVIDUAL:'),nl,
    write(TimetablesIndividual),
    %display_timetable(TimetablesIndividual,1),nl,
    write('GRUPOS:'),nl,
    write(TimetablesGroups),
    %display_timetable(TimetablesGroups,1),nl,

    print_time,
	fd_statistics.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

group_assignment_parser(_,[],[],[],_). %PERCORRE CADEIRA A CADEIRA
group_assignment_parser(TimetablesGroups,[ClassWorkHours|ClassWorkHoursTail],[ClassDeadLines|ClassDeadLinesTail],[ClassGroups|GroupWorkMembersTail],ClassIndex) :- %(percorre as diferentes cadeiras de indice ClassIndex)
    group_class_parser(TimetablesGroups,ClassWorkHours,ClassDeadLines,ClassGroups,ClassIndex),
    ClassIndexAux is ClassIndex + 1,
    group_assignment_parser(TimetablesGroups,ClassWorkHoursTail,ClassDeadLinesTail,GroupWorkMembersTail,ClassIndexAux).

group_class_parser(_,_,_,[],_). %Dentro duma cadeira, percorre os grupos dessa cadeira
group_class_parser(TimetablesGroups,GroupWorkHours,GroupWorkDeadlines,[WorkGroup|ClassGroupsTail],ClassIndex) :-
    enter_group_parser(TimetablesGroups,GroupWorkHours,GroupWorkDeadlines,WorkGroup,ClassIndex),

    group_class_parser(TimetablesGroups,GroupWorkHours,GroupWorkDeadlines,ClassGroupsTail,ClassIndex).

enter_group_parser(_,[],[],_,_).  %Entrar dentro de um Trabalho de horas WorkHour e data de entrega DeadLine
enter_group_parser(TimetablesGroups,[WorkHour|WorkHourTail],[DeadLine|DeadLineTail],WorkGroup,ClassIndex) :- 
    fill_group_with_work(TimetablesGroups,DeadLine,WorkGroup,ClassIndex,WorkedHours), %WorkHour=HorasTrab1 DeadLine=DeadlineTrab1 WorkGroup = [Elem1,Elem2]
    WorkedHours #= WorkHour,nl,
    
    enter_group_parser(TimetablesGroups,WorkHourTail,DeadLineTail,WorkGroup,ClassIndex).

fill_group_with_work(_,_,[],_,0).   %Tendo um elemento individual duma cadeira, para trabalho X e deadline X, mandar preencher horario desse elemento
fill_group_with_work(TimetablesGroups,DeadLine,[GroupElement|RestOfGroup],ClassIndex,WorkedHours) :-
    %nth1(GroupElement,TimetablesGroups,TimetableIndividual), %acede ao horario do elemento do grupo

    nth1HomeMade(TimetablesGroups,GroupElement,1,WorkedHours,DeadLine,ClassIndex),

    %write(TimetableIndividual),nl,
    %access_timetable_day(TimetableIndividual,DeadLine,ClassIndex,1,WorkedHoursActual),
    fill_group_with_work(TimetablesGroups,DeadLine,RestOfGroup,ClassIndex,WorkedHoursAux),
    WorkedHours #= WorkedHoursAux + WorkedHoursActual.
    %nl,write('WorkedHours: '),write(WorkedHours),nl,
    %write('WorkedHoursAux: '),write(WorkedHoursAux),nl,
    %write('WorkedHoursActual: '),write(WorkedHoursActual),nl.

nth1HomeMade([],_,_,_,_,_).
nth1HomeMade([TimetableInd|_],GroupElement,GroupElement,WorkedHours,DeadLine,ClassIndex) :-
    access_timetable_day(TimetableInd,DeadLine,ClassIndex,1,WorkedHours).
nth1HomeMade([TimetableInd|TimeTail],GroupElement,ActualIteration,WorkedHours,DeadLine,ClassIndex) :-
    ActualIterationAux is ActualIteration + 1,
    nth1HomeMade(TimeTail,GroupElement,ActualIterationAux,WorkedHours,DeadLine,ClassIndex).


access_timetable_day([],_,_,_,0). %Para quando se chega ao fim dos dias
access_timetable_day([Day|_],DeadLine,ClassIndex,DeadLine,NoOfOccurrences) :- %Para o caso de o deadline ser antes do fim dos dias
    write('ClassIndex77: '),write(ClassIndex),nl,
    write('Day77: '),write(Day),nl,
    counter_of_occurrences(ClassIndex,Day,NoOfOccurrences),
    write('NoOfOccurrences77: '),write(NoOfOccurrences),nl.

access_timetable_day([Day|Tail],DeadLine,ClassIndex,DayCounter,WorkedHours) :- %Preenche WorkedHours com a contagem de horas trabalhadas para este trabalho
    counter_of_occurrences(ClassIndex,Day,NoOfOccurrences),
    DayCounterAux is DayCounter + 1,

    access_timetable_day(Tail,DeadLine,ClassIndex,DayCounterAux,WorkedHoursAux),
    WorkedHours #=  WorkedHoursAux + NoOfOccurrences
    %nl,write('WorkedHours: '),write(WorkedHours),nl,
   % write('WorkedHoursAux: '),write(WorkedHoursAux),nl,
    %write('NoOfOccurrences: '),write(NoOfOccurrences),nl
    .


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Divides the list of Timetables 
individual_class_parser([],_,_).
individual_class_parser([Head|Tail],Timetables,ClassID) :-
    class_hours_verify_student(Head,Timetables,ClassID),
    ClassIDAux is (ClassID + 1),
    individual_class_parser(Tail,Timetables,ClassIDAux).

%Divides the list of students (Each Thead is the Timetable of a student)
class_hours_verify_student(_,[],_).
class_hours_verify_student(WeeklyHours,[Thead|Ttail],ClassID) :-
    class_hours_verify_week(WeeklyHours,Thead,ClassID),
    class_hours_verify_student(WeeklyHours,Ttail,ClassID).

%Counts and makes sure number of Hours spent in a week on a Class is exacly the WeeklyHours
class_hours_verify_week(WeeklyHours,[Day1,Day2,Day3,Day4,Day5,Day6|DayTail],ClassID) :-
    counter_of_occurrences(ClassID,Day1,NoOfOccurrences1),
    counter_of_occurrences(ClassID,Day2,NoOfOccurrences2),
    counter_of_occurrences(ClassID,Day3,NoOfOccurrences3),
    counter_of_occurrences(ClassID,Day4,NoOfOccurrences4),
    counter_of_occurrences(ClassID,Day5,NoOfOccurrences5),
    counter_of_occurrences(ClassID,Day6,NoOfOccurrences6),
    WeeklyHours #= NoOfOccurrences1+NoOfOccurrences2+NoOfOccurrences3+NoOfOccurrences4+NoOfOccurrences5+NoOfOccurrences6,
    class_hours_verify_week(WeeklyHours,DayTail,ClassID).
class_hours_verify_week(_,_,_).

%Counts number of Occurrences of SearchValue inside a List and returns NoOfOccurrences
counter_of_occurrences(_,[],0).
counter_of_occurrences(SearchValue,[Head|Tail],NoOfOccurrences) :- %searchlist: [0,0,0,0,0,0]
    SearchValue #= Head #<=> B,
    counter_of_occurrences(SearchValue,Tail,NoOfOccurrencesAux),
    NoOfOccurrences #= NoOfOccurrencesAux + B.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%restringe numero elementos de Timetables (1 Head = 1 aluno) e faz flat para processar no labeling
timetable_day_parser([],_,[],_).
timetable_day_parser([Head|Tail],NoOfDifferentClasses,FlattenedDayList,NoOfDays) :- 
    length(Head,NoOfDays),
    timetable_slot_parser(Head,NoOfDifferentClasses,FlattenedHead),
    timetable_day_parser(Tail,NoOfDifferentClasses,FlattenedTail,NoOfDays),
    append(FlattenedHead,FlattenedTail,FlattenedDayList).

%restringe numero de elementos em cada slot de Timetables(1 Head = 1 dia) e faz flat para processar no labeling
timetable_slot_parser([],_,[]).
timetable_slot_parser([Head|Tail],NoOfDifferentClasses,FlattenedSlotList) :-
    NoOfSlots is 10,
    length(Head,NoOfSlots), %Dentro de cada dia, 10 slots
    domain(Head,0,NoOfDifferentClasses),
    timetable_slot_parser(Tail,NoOfDifferentClasses,TailFlattened),
    append(Head,TailFlattened,FlattenedSlotList).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%append(?List1, ?List2, ?List1AndList2)
