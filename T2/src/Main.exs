alias SizeConfig, as: SizeConfig
alias RelationsBoard, as: RelationsBoard

defmodule Main do

  board_size = SizeConfig.size_board()
  row_region_size = SizeConfig.size_row_region()
  column_region_size = SizeConfig.size_column_region()
  relations_matrix = RelationsBoard.get_relations_board()

  IO.puts("Tamanho do tabuleiro: #{board_size}")
  IO.puts("Tamanho das regiões de linha: #{row_region_size}")
  IO.puts("Tamanho das regiões de coluna: #{column_region_size}")
  IO.puts("Matriz de relações: #{relations_matrix}")
end
