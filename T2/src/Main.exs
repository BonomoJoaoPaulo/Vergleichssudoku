alias SizeConfig, as: SizeConfig

defmodule Main do

  board_size = SizeConfig.size_board()
  row_region_size = SizeConfig.size_row_region()
  column_region_size = SizeConfig.size_column_region()

  IO.puts("Tamanho do tabuleiro: #{board_size}")
  IO.puts("Tamanho das regiões de linha: #{row_region_size}")
  IO.puts("Tamanho das regiões de coluna: #{column_region_size}")

end