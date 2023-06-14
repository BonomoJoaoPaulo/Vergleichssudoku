:- use_module(library(clpfd)).

% Command for swipl repl: solve(Sudoku), append(Sudoku, Vs), labeling([ff], Vs).

valid(A) :-
  member(A, [1, 2, 3, 4]).

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

blocks([A,B,C,D], Blocks) :-
  blocks(A,B,Block1), blocks(C,D,Block2),
  append([Block1, Block2], Blocks).

blocks([], [], []).
blocks([A,B|Bs1],[C,D|Bs2], [Block|Blocks]) :-
  Block = [A,B,C,D],
  blocks(Bs1, Bs2, Blocks).

printRow([]) :- nl.
printRow([H|T]) :-
  write(H),
  write(' '),
  printRow(T).

solve(Solution) :-
  % Problem 1 - 4x4
  Solution = [
    [A1, A2, A3, A4], 
    [B1, B2, B3, B4], 
    [C1, C2, C3, C4], 
    [D1, D2, D3, D4]],

  flatten(Solution, Tmp), Tmp ins 1..4, % All elements are between 1 and 4
  Rows = Solution,
  transpose(Rows, Columns),
  blocks(Rows, Blocks),
  maplist(all_different, Rows),
  maplist(all_different, Columns),
  maplist(all_different, Blocks), 

  % Solution is presented in blocks (like the ones in sudoku), starting at the top left corner
  % Block 1
  smaller(A1, A2), % line 1
  smaller(B1, B2), % line 2
  bigger(A1, B1), % column 1
  smaller(A2, B2), % column 2

  % Block 2
  smaller(A3, A4), % line 1
  bigger(B3, B4), % line 2
  smaller(A3, B3), % column 3
  bigger(A4, B4), % column 4

  % Block 3
  bigger(C1, C2), % line 3
  bigger(D1, D2), % line 4
  bigger(C1, D1), % column 1
  smaller(C2, D2), % column 2

  % Block 2
  smaller(C3, C4), % line 3
  bigger(D3, D4), % line 4
  smaller(C3, D3), % column 3
  bigger(C4, D4), % column 4


  maplist(label, Solution),
  maplist(printRow, Solution), !.