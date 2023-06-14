:- use_module(library(clpfd)).

% Command for swipl repl: solve(Sudoku), append(Sudoku, Vs), labeling([ff], Vs).

valid(A) :-
  member(A, [1, 2, 3, 4, 5, 6, 7, 8, 9]).

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

blocks([A,B,C,D,E,F,G,H,I], Blocks) :-
  blocks(A,B,C,Block1), blocks(D,E,F,Block2), blocks(G,H,I,Block3),
  append([Block1, Block2, Block3], Blocks).

blocks([], [], [], []).
blocks([A,B,C|Bs1],[D,E,F|Bs2],[G,H,I|Bs3], [Block|Blocks]) :-
  Block = [A,B,C,D,E,F,G,H,I],
  blocks(Bs1, Bs2, Bs3, Blocks).

printRow([]) :- nl.
printRow([H|T]) :-
  write(H),
  write(' '),
  printRow(T).

solve(Solution) :-
  % Problem 11 - 9x9
  Solution = [
    [A1, A2, A3, A4, A5, A6, A7, A8, A9], 
    [B1, B2, B3, B4, B5, B6, B7, B8, B9], 
    [C1, C2, C3, C4, C5, C6, C7, C8, C9], 
    [D1, D2, D3, D4, D5, D6, D7, D8, D9], 
    [E1, E2, E3, E4, E5, E6, E7, E8, E9], 
    [F1, F2, F3, F4, F5, F6, F7, F8, F9],
    [G1, G2, G3, G4, G5, G6, G7, G8, G9], 
    [H1, H2, H3, H4, H5, H6, H7, H8, H9], 
    [I1, I2, I3, I4, I5, I6, I7, I8, I9]],
  flatten(Solution, Tmp), Tmp ins 1..9, % All elements are between 1 and 9
  Rows = Solution,
  transpose(Rows, Columns),
  blocks(Rows, Blocks),
  maplist(all_different, Rows),
  maplist(all_different, Columns),
  maplist(all_different, Blocks), 

  % Solution is presented in blocks (like the ones in sudoku), starting at the top left corner
  % Block 1
  smallerBigger(A1, A2, A3), % line 1
  smallerSmaller(B1, B2, B3), % line 2
  smallerSmaller(C1, C2, C3), % line 3
  biggerSmaller(A1, B1, C1), % column 1
  smallerSmaller(A2, B2, C2), % column 2
  smallerSmaller(A3, B3, C3), % column 3

  % Block 2
  smallerSmaller(A4, A5, A6), % line 1
  smallerBigger(B4, B5, B6), % line 2
  smallerBigger(C4, C5, C6), % line 3
  biggerSmaller(A4, B4, C4), % column 4
  biggerBigger(A5, B5, C5), % column 5
  biggerBigger(A6, B6, C6), % column 6


  % Block 3
  biggerBigger(A7, A8, A9), % line 1
  biggerSmaller(B7, B8, B9), % line 2
  biggerSmaller(C7, C8, C9), % line 3
  smallerBigger(A7, B7, C7), % column 7
  biggerBigger(A8, B8, C8), % column 8
  smallerBigger(A9, B9, C9), % column 9
  
  % Block 4
  biggerBigger(D1, D2, D3), % line 4
  biggerSmaller(E1, E2, E3), % line 5
  smallerBigger(F1, F2, F3), % line 6
  biggerBigger(D1, E1, F1), % column 1
  smallerSmaller(D2, E2, F2), % column 2
  smallerSmaller(D3, E3, F3), % column 3

  % Block 5
  biggerSmaller(D4, D5, D6), % line 4
  biggerSmaller(E4, E5, E6), % line 5
  smallerBigger(F4, F5, F6), % line 6
  biggerSmaller(D4, E4, F4), % column 4
  biggerSmaller(D5, E5, F5), % column 5
  biggerBigger(D6, E6, F6), % column 6

  % Block 6
  smallerBigger(D7, D8, D9), % line 4
  biggerBigger(E7, E8, E9), % line 5
  biggerSmaller(F7, F8, F9), % line 6
  smallerBigger(D7, E7, F7), % column 7
  biggerBigger(D8, E8, F8), % column 8
  smallerBigger(D9, E9, F9), % column 9

  % Block 7
  smallerBigger(G1, G2, G3), % line 7
  biggerSmaller(H1, H2, H3), % line 8
  smallerBigger(I1, I2, I3), % line 9
  biggerSmaller(G1, H1, I1), % column 1
  biggerSmaller(G2, H2, I2), % column 2
  biggerBigger(G3, H3, I3), % column 3

  % Block 8
  biggerBigger(G4, G5, G6), % line 7
  biggerSmaller(H4, H5, H6), % line 8
  smallerSmaller(I4, I5, I6), % line 9
  smallerBigger(G4, H4, I4), % column 4
  biggerBigger(G5, H5, I5), % column 5
  biggerSmaller(G6, H6, I6), % column 6

  % Block 9
  smallerBigger(G7, G8, G9), % line 7
  smallerSmaller(H7, H8, H9), % line 8
  smallerBigger(I7, I8, I9), % line 9
  smallerBigger(G7, H7, I7), % column 7
  smallerSmaller(G8, H8, I8), % column 8
  smallerBigger(G9, H9, I9), % column 9

  maplist(label, Solution),
  maplist(printRow, Solution), !.