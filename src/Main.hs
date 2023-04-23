module Main where

import SizeConfig (sizeBoard)
import RelationsBoard (getRelationsBoard)
import VergleichssudokuSolver(getVergleichssudokuGrid, solveVergleichssudoku)
import PrintBoard(printBoard)

main = do
    printBoard (solveVergleichssudoku (getVergleichssudokuGrid sizeBoard) getRelationsBoard 0 0)
