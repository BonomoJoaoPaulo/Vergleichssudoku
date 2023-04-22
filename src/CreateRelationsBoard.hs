module CreateRelationsBoard (createRelationsBoard) where

import InputSizeReader (sizeBoard)

createRelationsBoard :: Int -> IO ()
createRelationsBoard sizeBoard = do
    if sizeBoard == 4
        then do 
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 4x4:"
            row1 <- getLine
            row2 <- getLine
            row3 <- getLine
            row4 <- getLine
            let allRows = [row1, row2, row3, row4]
            let relationsBoard = getRelationsBoard allRows
            print relationsBoard

    else if sizeBoard == 6
        then do 
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 6x6:"
            row1 <- getLine
            row2 <- getLine
            row3 <- getLine
            row4 <- getLine
            row5 <- getLine
            row6 <- getLine
            let allRows = [row1, row2, row3, row4, row5, row6]
            let relationsBoard = getRelationsBoard allRows
            print relationsBoard

    else if sizeBoard == 9
        then do
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 9x9:"
            row1 <- getLine
            row2 <- getLine
            row3 <- getLine
            row4 <- getLine
            row5 <- getLine
            row6 <- getLine
            row7 <- getLine
            row8 <- getLine
            row9 <- getLine
            let allRows = [row1, row2, row3, row4, row5, row6, row7, row8, row9]
            let relationsBoard = getRelationsBoard allRows
            print relationsBoard
    else
        putStrLn "As dimensões do tabuleiro fornecidas são inválidas."

getPipeOut :: [Char] -> [Char]
getPipeOut [] = []
getPipeOut (x:xs) = if x /= '|' then x : getPipeOut xs else []

getAllRelationsFromRow :: [Char] -> [[Char]]
getAllRelationsFromRow [] = []
getAllRelationsFromRow rawRow = take 4 row : getAllRelationsFromRow (drop (4+1) row) -- 4 IS HARDCORDED HERE (NEED TO BE FIXED)
    where
        row = getPipeOut rawRow

getRelationsBoard :: [[Char]] -> [[[Char]]]
getRelationsBoard allRows = map getAllRelationsFromRow allRows
