module RelationsBoard (getRelationsBoard) where

  import SizeConfig (sizeBoard)
  import Debug.Trace (trace)

  -- INPUT 0001
  row1size4 :: [Char]
  row2size4 :: [Char]
  row3size4 :: [Char]
  row4size4 :: [Char]
  row1size4 = ".<>.|..<>|.<<.|..>>|"
  row2size4 = "<<..|>..>|>>..|<..<|"
  row3size4 = ".>>.|..<<|.<<.|..>>|"
  row4size4 = "<>..|>..<|>>..|<..<|"

  -- INPUT 004
  row1size6 :: [Char]
  row2size6 :: [Char]
  row3size6 :: [Char]
  row4size6 :: [Char]
  row5size6 :: [Char]
  row6size6 :: [Char]
  row1size6 = ".<<.|..>>|.><.|..<<|.><.|..><|"
  row2size6 = ">>>.|<.><|>>>.|>.<<|>><.|<.<<|"
  row3size6 = "<<..|<..>|<<..|>..>|><..|>..>|"
  row4size6 = ".<<.|..<>|.<>.|..>>|.<<.|..>>|"
  row5size6 = ">>>.|>.><|<<<.|<.<>|><<.|<.>>|"
  row6size6 = "<>..|<..<|><..|>..>|>>..|<..<|"

  -- INPUT 011
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
    | size == 6 = [row1size6, row2size6, row3size6, row4size6, row5size6, row6size6]
    | size == 4 = [row1size4, row2size4, row3size4, row4size4]
    | otherwise = error "Invalid size"

  takePipeOut :: [Char] -> [Char]
  takePipeOut [] = []
  takePipeOut (x:xs) = if x /= '|' then x : takePipeOut xs else takePipeOut xs

  takeAllComparatorsFromRow :: [Char] -> [[Char]]
  takeAllComparatorsFromRow [] = []
  takeAllComparatorsFromRow rawRow = take 4 row : takeAllComparatorsFromRow (drop 4 row)
                                        where
                                          row = takePipeOut rawRow

  getRelationsBoard :: [[[Char]]]
  getRelationsBoard = map takeAllComparatorsFromRow (allRows sizeBoard)
