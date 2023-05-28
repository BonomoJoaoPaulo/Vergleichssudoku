defmodule SizeConfig do
  @moduledoc """
  Configura o tabuleiro
  """
  @sizeBoard 4
  @sizeRowRegion 2
  @sizeColumnRegion 2

  @doc """
  Variável referente ao tamanho do tabuleiro.
  Usuario pode escolher entre 4, 6 e 9.
  """
  @spec sizeBoard() :: integer
  def sizeBoard(), do: @sizeBoard

  @doc """
  Variável referente ao número de linhas de cada região do tabuleiro.
  Para um sizeBoard == 4, sizeRowRegion = 2; Para um sizeBoard == 6 ou sizeBoard == 9, sizeRowRegion = 3.
  """
  @spec sizeRowRegion() :: integer
  def sizeRowRegion(), do: @sizeRowRegion

  @doc """
  Variável referente ao número de colunas de cada região do tabuleiro.
  Para um sizeBoard == 4 ou sizeBoard == 6, sizeRowRegion = 2; Para um sizeBoard == 9, sizeRowRegion = 3.
  """
  @spec sizeColumnRegion() :: integer
  def sizeColumnRegion(), do: @sizeColumnRegion
end
