module CreateRelationsBoard (createRelationsBoard) where

import InputSizeReader (sizeBoard)

createRelationsBoard :: Int -> IO ()
createRelationsBoard sizeBoard = do
    if sizeBoard == 4
        then do 
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 4:"
            block1 <- getLine
            block2 <- getLine
            block3 <- getLine
            block4 <- getLine
            return ()

    else if sizeBoard == 6
        then do 
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 6:"
            block1 <- getLine
            block2 <- getLine
            block3 <- getLine
            block4 <- getLine
            block5 <- getLine
            block6 <- getLine
            return ()
    else if sizeBoard == 9
        then do
            putStrLn "Informe as relações de cada bloco para o tabuleiro de tamanho 9:"
            block1 <- getLine
            block2 <- getLine
            block3 <- getLine
            block4 <- getLine
            block5 <- getLine
            block6 <- getLine
            block7 <- getLine
            block8 <- getLine
            block9 <- getLine
            return ()
    else
        putStrLn "O tamanho do tabuleiro fornecido é inválido."