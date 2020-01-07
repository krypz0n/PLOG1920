% Reads an int from the input stream, verifying if it's actually an int
get_clean_int(I) :-
    catch(read(I), _, true),
    get_char(_),
    integer(I).
        
get_clean_int(I) :-
    write('<<< Invalid Input >>>\n\n'), get_clean_int(I).

% Retrieves the input from the user
manual_input(StudentList,NoStudents,ClassList,ClassNo) :-
    write('Student Ammount: '),
    get_clean_int(NoStudents), nl,
    StudentAux is (NoStudents + 1),
    create_students(NoStudents, StudentAux, StudentList),
    write('Students Created!'),nl.
    %write('Class Amount: '),
    %get_clean_int(ClassNo), nl,
    %length(ClassList, ClassNo).
    %create_classes(ClassNo, StudentList, ClassList). %not implemented yet

% Creates the Students with inputs from the user % MISSING somethings
create_students(0, _, []).
create_students(NoStudents, StudentAux, [Student | RestOfStudentList])  :-
    StudentNumber is (StudentAux - NoStudents),
    write('-----------'), nl,
    write('Student #'), write(StudentNumber), nl,
    write('-----------'), nl, 
    write('Number of Classes: '), get_clean_int(NoClasses), nl,
    assign_classes(NoClasses,ClassListStudent),
    write('Showing class list: '),nl,
    show_list_elements(ClassListStudent),
    Student = [NoClasses, ClassListStudent], 
    NoStudentAux is (NoStudents - 1),
    
    create_students(NoStudentAux, StudentAux, RestOfStudentList).

% Allows user to select the Students Attending Classes % isto ta a bater mal, pensar melhor
assign_classes(0,_).
assign_classes(NoClasses,ClassListStudent) :-
    NoClassesAux is (NoClasses - 1),
    write('NoClassesAux #'), write(NoClassesAux),nl,
    write('Class Name/ID #'), get_clean_int(ClassID), nl,
    append(ClassListStudent,[ClassID],ClassListStudentAux),
    assign_classes(NoClassesAux,ClassListStudentAux).


show_list_elements([]) :-
    nl.
show_list_elements([A|B]) :-
  write('ClassID: '),write(A),write(' '),
  show_list_elements(B).

%

%append(?List1, ?List2, ?List1AndList2)

%write('NoClasses #'), write(NoClasses), nl,
%write('-----------'), nl,
%write('Class Name/ID #'), get_clean_int(ClassID), nl,
%append(ClassListStudent,[ClassID],ClassListStudentAux),
%NoClassesAux is(NoClasses -1),