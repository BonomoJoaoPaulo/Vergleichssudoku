:- use_module(library(clpfd)).

% Command for swipl repl: solve(Sudoku), append(Sudoku, Vs), labeling([ff], Vs).

valid(A) :-
  member(A, [1, 2, 3, 4, 5, 6]).

validate([]).
validate([H|T]) :-
  not(member(H, T)),
  validate(T).

bigger(A, B) :-
  valid(A),
  valid(B),
  A > B.

smaller(A, B) :-
  valid(A),
  valid(B),
  A < B.

biggerBigger(A, B, C) :-
  bigger(A, B),
  bigger(B, C).

biggerSmaller(A, B, C) :-
  bigger(A, B),
  smaller(B, C).

smallerBigger(A, B, C) :-
  smaller(A, B),
  bigger(B, C).

smallerSmaller(A, B, C) :-
  smaller(A, B),
  smaller(B, C).

blocks([A,B,C,D,E,F], Blocks) :-
  blocks(A,B,C,Block1), blocks(D,E,F,Block2),
  append([Block1, Block2], Blocks).

blocks([], [], [], []).
blocks([A,B,C|Bs1],[D,E,F|Bs2], [Block|Blocks]) :-
  Block = [A,B,C,D,E,F],
  blocks(Bs1, Bs2, Blocks).

printRow([]) :- nl.
printRow([H|T]) :-
  write(H),
  write(' '),
  printRow(T).

solve(Solution) :-
  % Problem 4 - 6x6
  Solution = [
    [A1, A2, A3, A4, A5, A6], 
    [B1, B2, B3, B4, B5, B6], 
    [C1, C2, C3, C4, C5, C6], 
    [D1, D2, D3, D4, D5, D6], 
    [E1, E2, E3, E4, E5, E6], 
    [F1, F2, F3, F4, F5, F6]],
  flatten(Solution, Tmp), Tmp ins 1..6, % All elements are between 1 and 9
  Rows = Solution,
  transpose(Rows, Columns),
  blocks(Rows, Blocks),
  maplist(all_different, Rows),
  maplist(all_different, Columns),
  maplist(all_different, Blocks), 

  % Solution is presented in blocks (like the ones in sudoku), starting at the top left corner
  % Block 1
  smaller(A1, A2), % line 1
  bigger(B1, B2), % line 2
  smaller(C1, C2), % line 3
  smallerBigger(A1, B1, C1), % column 1
  biggerBigger(A2, B2, C2), % column 2

  % Block 2
  bigger(A3, A4), % line 1
  bigger(B3, B4), % line 2
  smaller(C3, C4), % line 3
  smallerBigger(A3, B3, C3), % column 3
  smallerSmaller(A4, B4, C4), % column 4


  % Block 3
  bigger(A5, A6), % line 1
  bigger(B5, B6), % line 2
  smaller(C5, C6), % line 3
  smallerSmaller(A5, B5, C5), % column 5
  biggerSmaller(A6, B6, C6), % column 6
  
  % Block 4
  smaller(D1, D2), % line 4
  bigger(E1, E2), % line 5
  bigger(F1, F2), % line 6
  smallerBigger(D1, E1, F1), % column 1
  smallerBigger(D2, E2, F2), % column 2

  % Block 5
  smaller(D3, D4), % line 4
  smaller(E3, E4), % line 5
  smaller(F3, F4), % line 6
  biggerSmaller(D3, E3, F3), % column 3
  biggerSmaller(D4, E4, F4), % column 4

  % Block 6
  smaller(D5, D6), % line 4
  smaller(E5, E6), % line 5
  bigger(F5, F6), % line 6
  smallerSmaller(D5, E5, F5), % column 5
  biggerBigger(D6, E6, F6), % column 6

  maplist(label, Solution),
  maplist(printRow, Solution), !.