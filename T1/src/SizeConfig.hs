module SizeConfig (sizeBoard, sizeRowRegion, sizeColumnRegion) where
    sizeBoard :: Int -- Variável referente ao tamanho do tabuleiro.
    sizeBoard = 6 -- Usuario pode escolher entre 4, 6 e 9.

    sizeRowRegion :: Int -- Variável referente ao número de linhas de cada região do tabuleiro.
    sizeRowRegion = 3 -- Para um sizeBoard == 4, sizeRowRegion = 2; Para um sizeBoard == 6 ou sizeBoard == 9, sizeRowRegion = 3.

    sizeColumnRegion :: Int -- Variável referente ao número de colunas de cada região do tabuleiro.
    sizeColumnRegion = 2 -- Para um sizeBoard == 4 ou sizeBoard == 6, sizeRowRegion = 2; Para um sizeBoard == 9, sizeRowRegion = 3.
