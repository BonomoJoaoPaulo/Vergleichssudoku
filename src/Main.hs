module Main where

import InputSizeReader (sizeBoard)
import CreateRelationsBoard (createRelationsBoard)

main :: IO ()
main = do
    sizeBoard <- sizeBoard
    createRelationsBoard(sizeBoard)
    putStrLn ("O tamanho do tabuleiro é " ++ show sizeBoard)