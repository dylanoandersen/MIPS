% CSCE 480
% Prof. Kim

:- set_prolog_flag(answer_write_options, [max_depth(0), max_length(0)]).

maze1([['\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588'],
       ['\u2588','+','\u2588',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ',' ','-','\u2588'],
       ['\u2588',' ','\u2588',' ','\u2588',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588'],
       ['\u2588',' ',' ',' ','\u2588',' ','\u2588','\u2588','\u2588',' ','$','\u2588',' ',' ',' ','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588',' ','\u2588',' ',' ',' ','\u2588',' ','\u2588','\u2588',' ','\u2588',' ',' ',' ','\u2588'],
       ['\u2588',' ','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588',' ','\u2588',' ',' ','\u2588',' ','\u2588','\u2588','\u2588'],
       ['\u2588',' ','\u2588',' ',' ',' ','\u2588',' ','\u2588',' ','\u2588',' ','\u2588','\u2588',' ','\u2588','\u2588','\u2588'],
       ['\u2588',' ','\u2588','$','\u2588',' ',' ',' ',' ',' ',' ',' ','\u2588','\u2588',' ','\u2588','\u2588','\u2588'],
       ['\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588',' ',' ','\u2588',' ',' ',' ','\u2588'],
       ['\u2588',' ',' ',' ','\u2588','$','\u2588',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588'],
       ['\u2588','$','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ','\u2588'],
       ['\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588']]).

maze2([['\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588'],
       ['\u2588','+','\u2588',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','-',' ','\u2588'],
       ['\u2588',' ','\u2588',' ','\u2588',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588'],
       ['\u2588',' ',' ',' ','\u2588',' ','\u2588','\u2588','\u2588',' ','$','\u2588',' ',' ',' ','\u2588',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','$','\u2588',' ',' ',' ','\u2588'],
       ['\u2588',' ','\u2588',' ','\u2588',' ',' ',' ','\u2588',' ','\u2588','\u2588',' ','\u2588',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588',' ','\u2588',' ',' ','\u2588',' ','\u2588','\u2588','\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588',' ',' ',' ','\u2588',' ','\u2588',' ','\u2588',' ','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588'],
       ['\u2588',' ','\u2588','$','\u2588',' ',' ',' ',' ',' ',' ',' ','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ',' ','\u2588',' ',' ','\u2588'],
       ['\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588',' ',' ','\u2588',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ','\u2588',' ','\u2588'],
       ['\u2588',' ',' ',' ','\u2588','$','\u2588',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588',' ',' ',' ',' ',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ','\u2588',' ','\u2588'],
       ['\u2588','$','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ','\u2588','\u2588','\u2588','\u2588',' ',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588'],
       ['\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ','$',' ',' ',' ','\u2588'],
       ['\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ','\u2588',' ',' ','\u2588',' ',' ',' ',' ','\u2588','\u2588',' ',' ',' ','\u2588','\u2588','\u2588',' ','\u2588',' ','\u2588','\u2588',' ','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588'],
       ['\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588',' ','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','\u2588'],
       ['\u2588',' ',' ',' ',' ',' ',' ',' ','\u2588',' ','\u2588',' ',' ','\u2588',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ','\u2588',' ','\u2588'],
       ['\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ','\u2588',' ','\u2588'],
       ['\u2588','$','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ',' ',' ',' ',' ',' ',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ',' ','\u2588','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ','$',' ',' ',' ','\u2588'],
       ['\u2588',' ',' ',' ',' ',' ',' ',' ','\u2588',' ','\u2588',' ',' ','\u2588',' ',' ',' ','\u2588','\u2588','\u2588',' ','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588',' ','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588',' ',' ',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ',' ','\u2588',' ',' ','\u2588',' ','\u2588'],
       ['\u2588',' ','\u2588',' ',' ',' ','\u2588',' ','\u2588',' ','\u2588',' ',' ',' ',' ','\u2588',' ','\u2588','\u2588','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588',' ','\u2588','\u2588','\u2588','\u2588'],
       ['\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588','\u2588']]).

print_maze(Maze) :- 
    maplist(print_row, Maze). % maplist is applied to each element 
                              % for Maze, each "element" is a row 
                              % since Maze is a 2D list which is a list of lists
print_row(Row) :- 
    maplist(write, Row), nl.  % print each element (character) in Row

find_this(Maze, X,Y, This) :-
    nth0(X,Maze,Row),
    nth0(Y,Row,This).

find_start(Maze, X,Y) :-
    nth0(X,Maze,Row),
    nth0(Y,Row,'+').

replace([_|Tail], 0, Item, [Item|Tail]).
replace([Head|Tail], Index, Item, [Head|NewTail]) :-
    Index > 0,
    Index1 is Index - 1,
    replace(Tail, Index1, Item, NewTail).

replace2D([CurRow|OtherRows], 0, Col, Item, [NewRow|OtherRows]) :-
    replace(CurRow, Col, Item, NewRow).
replace2D([CurRow|OtherRows], Row, Col, Item, [CurRow|NewOtherRows]) :-
    Row > 0,
    Row1 is Row - 1,
    replace2D(OtherRows, Row1, Col, Item, NewOtherRows).

adjacent(X, Y, A, B) :-
    (A is X - 1,
    B is Y);
    (A is X + 1,
    B is Y);
    (A is X,
    B is Y - 1);
    (A is X,
    B is Y + 1).

start_move(M, X, Y, [[X, Y]|Path]) :-
    adjacent(X, Y, A, B),
    move(M, A, B, Path).

start_move1(M, X, Y, [[X, Y]|Path]) :-
    adjacent(X, Y, A, B),
    move1(M, A, B, Path).

move(M, X, Y, [[X,Y]]) :-
    find_this(M, X, Y, '$'),
    print_maze(M).

move(M, X, Y, [[X,Y]|Path]) :-
    find_this(M, X, Y, ' '),
    replace2D(M, X, Y, '.', NewMaze),
    adjacent(X, Y, A, B),
    move(NewMaze, A, B, Path).

move1(M, X, Y, [[X,Y]]) :-
    find_this(M, X, Y, '-'),
    print_maze(M).

move1(M, X, Y, [[X,Y]|Path]) :-
    find_this(M, X, Y, ' '),
    replace2D(M, X, Y, '.', NewMaze),
    adjacent(X, Y, A, B),
    move1(NewMaze, A, B, Path).

solve_maze(MazeName, Path) :-
    (call(MazeName, M),
    find_start(M, StartX, StartY),  
    start_move(M, StartX, StartY, Path));
    (call(MazeName, M),
    find_this(M, X, Y, '$'),
    start_move(M, X, Y, Path));
    (call(MazeName, M),
    find_this(M, X, Y, '$'),
    start_move1(M, X, Y, Path)).

reset_maze(_, Maze) :-
    call(maze1, Maze).

clear_list(_, []).