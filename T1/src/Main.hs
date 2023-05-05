module Main where

import SizeConfig (sizeBoard)
import RelationsBoard (getRelationsBoard)
import VergleichssudokuSolver(getVergleichssudokuGrid, solveVergleichssudoku)
import BoardPrinter(printBoard)

main = do
    putStrLn "WELLCOME TO VERGLEICHSSUDOKU SOLVER!"
    printBoard (solveVergleichssudoku (getVergleichssudokuGrid sizeBoard) getRelationsBoard 0 0)
