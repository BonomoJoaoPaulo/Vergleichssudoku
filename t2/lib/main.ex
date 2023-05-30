defmodule Main do
  @moduledoc """
  Módulo da Aplicação
  """

  @doc """
  Roda a aplicação
  """
  def run() do
    IO.puts("WELCOME TO VERGLEICHSSUDOKU SOLVER!")

    BoardPrinter.printBoard(
      VergleichsSudoku.solveVergleichsSudoku(
        VergleichsSudoku.getVergleichsSudokuGrid(SizeConfig.sizeBoard()),
        RelationsBoard.getRelationsBoard(),
        0,
        0
      )
    )
  end
end

# Verifica se o módulo atual é o que está sendo invocado diretamente
if __MODULE__ == __MODULE__ do
  Main.run()
end
