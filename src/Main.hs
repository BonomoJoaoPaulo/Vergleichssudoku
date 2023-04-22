module Main where

import SizeConfig (sizeBoard)
import RelationsBoard (getRelationsBoard)
import SudokuSolver(getSudokuGrid, solveSudoku)
import PrintBoard(printBoard)

main = do
    printBoard (solveSudoku (getSudokuGrid sizeBoard) getRelationsBoard 0 0)