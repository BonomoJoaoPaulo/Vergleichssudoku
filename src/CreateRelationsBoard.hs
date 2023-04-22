module RelationsBoard (getComparatorsGrid) where

  import SizeConfig (sizeBoard)
  import Debug.Trace (trace)

  row1size4 :: [Char]
  row2size4 :: [Char]
  row3size4 :: [Char]
  row4size4 :: [Char]
  row1size4 = ".<>.|..<>|.<<.|..>>|"
  row2size4 = "<<..|>..>|>>..|<..<|"
  row3size4 = ".>>.|..<<|.<<.|..>>|"
  row4size4 = "<>..|>..<|>>..|<..<|"

  row1size9 :: [Char]
  row2size9 :: [Char]
  row3size9 :: [Char]
  row4size9 :: [Char]
  row5size9 :: [Char]
  row6size9 :: [Char]
  row7size9 :: [Char]
  row8size9 :: [Char]
  row9size9 :: [Char]
  row1size9 = ".<>.|.><>|..<<|.<>.|.<>>|..>>|.><.|.>><|..<<|"
  row2size9 = "<<<.|><<>|>.<>|<<<.|<>>>|<.><|>>>.|<<><|>.>>|"
  row3size9 = "><..|><.>|>..>|><..|<>.>|<..<|<>..|<<.<|<..>|"
  row4size9 = ".>>.|.><<|..<<|.>>.|.<><|..>>|.<<.|.>>>|..<<|"
  row5size9 = "<>>.|><<<|>.<>|<><.|<<<<|<.>>|>>>.|<>><|>.><|"
  row6size9 = "<<..|>>.>|>..<|><..|>>.>|<..<|<>..|<<.<|<..>|"
  row7size9 = ".<>.|.>>>|..><|.><.|.>><|..><|.<<.|.><>|..<<|"
  row8size9 = "<><.|<<<<|<.>>|>>>.|<<><|<.<>|><>.|><<>|>.>>|"
  row9size9 = "><..|>>.>|<..<|<<..|<<.>|>..>|<<..|>>.>|<..<|"

  allRows :: Int -> [[Char]]
  allRows size
    | size == 9 = [row1size9, row2size9, row3size9, row4size9, row5size9, row6size9, row7size9, row8size9, row9size9]
    | size == 4 = [row1size4, row2size4, row3size4, row4size4]
    | otherwise = error "Invalid size"

  takePipeOut :: [Char] -> [Char]
  takePipeOut [] = []
  takePipeOut (x:xs) = if x /= '|' then x : takePipeOut xs else takePipeOut xs

  takeAllComparatorsFromRow :: [Char] -> [[Char]]
  takeAllComparatorsFromRow [] = []
  takeAllComparatorsFromRow rawRow = take 4 row : takeAllComparatorsFromRow (drop 4 row) -- EDIT HERE THE SIZE
                                        where
                                          row = takePipeOut rawRow

  getComparatorsGrid :: [[[Char]]]
  getComparatorsGrid = map takeAllComparatorsFromRow (allRows sizeBoard)