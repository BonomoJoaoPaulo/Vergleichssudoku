module BoardPrinter (printBoard) where

printLine :: [Int] -> IO ()
printLine [] = putStrLn ""
printLine (x:xs) = do
    putStr (show x)
    putStr " "
    printLine xs

printBoard :: Maybe [[Int]] -> IO()
printBoard board = do
    case board of
        Nothing -> putStrLn "NENHUMA SOLUÇÃO ENCONTRADA."
        Just (x:xs) -> do
            case xs of
                [] -> printLine x
                _ -> do
                    printLine x
                    printBoard (Just xs)
