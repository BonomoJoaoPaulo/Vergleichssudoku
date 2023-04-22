module Main where

import InputSizeReader (sizeBoard)
import CreateRelationsBoard (createRelationsBoard)
import SudokuSolver(getSudokuGrid, solveSudoku)
import PrintBoard(printBoard)

main :: IO ()
main = do
    sizeBoard <- sizeBoard
    createRelationsBoard(sizeBoard)
    putStrLn ("O tamanho do tabuleiro é " ++ show sizeBoard)
    printBoard (solveSudoku (getSudokuGrid sizeBoard) getRelationsBoard 0 0)