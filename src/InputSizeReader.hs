module InputSizeReader (sizeBoard) where
    sizeBoard :: IO Int
    sizeBoard = do
        putStrLn "Enter the size of the board: "
        size <- getLine
        let sizeBoard = read size :: Int

        return sizeBoard
