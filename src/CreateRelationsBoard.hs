module CreateRelationsBoard (createRelationsBoard) where

import InputSizeReader (sizeBoard)

createRelationsBoard :: Int -> IO ()
createRelationsBoard sizeBoard = do
    if sizeBoard == 4
        then do 
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 4x4:"
            row1 :: [Char]
            row2 :: [Char]
            row3 :: [Char]
            row4 :: [Char]
            row1 <- getLine
            row2 <- getLine
            row3 <- getLine
            row4 <- getLine
            return ()

    else if sizeBoard == 6
        then do 
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 6x6:"
            row1 :: [Char]
            row2 :: [Char]
            row3 :: [Char]
            row4 :: [Char]
            row5 :: [Char]
            row6 :: [Char]
            row1 <- getLine
            row2 <- getLine
            row3 <- getLine
            row4 <- getLine
            row5 <- getLine
            row6 <- getLine
            return ()
    else if sizeBoard == 9
        then do
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 9x9:"
            row1 :: [Char]
            row2 :: [Char]
            row3 :: [Char]
            row4 :: [Char]
            row5 :: [Char]
            row6 :: [Char]
            row7 :: [Char]
            row8 :: [Char]
            row9 :: [Char]
            row1 <- getLine
            row2 <- getLine
            row3 <- getLine
            row4 <- getLine
            row5 <- getLine
            row6 <- getLine
            row7 <- getLine
            row8 <- getLine
            row9 <- getLine
            return ()
    else
        putStrLn "As dimensões do tabuleiro fornecidas são inválidas."
    
    allRows :: Int -> [[Char]]
    allRows size
        | size == 4 = [row1, row2, row3, row4]
        | size == 6 = [row1, row2, row3, row4, row5, row6]
        | size == 9 = [row1, row2, row3, row4,row5, row6, row7, row8, row9]
        | otherwise = error "Invalid size!"

    getPipeOut :: [Char] -> [Char]
    getPipeOut [] = []
    getPipeOut (x:xs) = if x /= '|' then x : takePipeOut xs else takePipeOut xs


    getAllRelationsFromRow :: [Char] -> [[Char]]
    getAllRelationsFromRow [] = []
    getAllRelationsFromRow rawRow = take sizeBoard row : takeAllComparatorsFromRow (drop sizeBoard row)
                                        where
                                          row = getPipeOut rawRow

    createRelationsBoard :: [[[Char]]]
    createRelationsBoard = map getAllRelationsFromRow (allRows sizeBoard)
