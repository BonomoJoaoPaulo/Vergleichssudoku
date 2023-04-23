module Main where

import SizeConfig (sizeBoard)
import RelationsBoard (getRelationsBoard)
import SudokuSolver(getVergleichssudokuGrid, solveVergleichssudoku)
import PrintBoard(printBoard)

main = do
    printBoard (solveVergleichssudoku (getVergleichssudokuGrid sizeBoard) getRelationsBoard 0 0)
