defmodule SizeConfig do
  @moduledoc """
  Configura o tabuleiro
  """

  @doc """
  Variável referente ao tamanho do tabuleiro.
  Usuario pode escolher entre 4, 6 e 9.
  """
  @spec sizeBoard() :: integer
  def sizeBoard() do
    sizeBoard = 6
  end

  @doc """
  Variável referente ao número de linhas de cada região do tabuleiro.
  Para um sizeBoard == 4, sizeRowRegion = 2; Para um sizeBoard == 6 ou sizeBoard == 9, sizeRowRegion = 3.
  """
  @spec sizeRowRegion() :: integer
  def sizeRowRegion() do
    sizeRowRegion = 3
  end

  @doc """
  Variável referente ao número de colunas de cada região do tabuleiro.
  Para um sizeBoard == 4 ou sizeBoard == 6, sizeRowRegion = 2; Para um sizeBoard == 9, sizeRowRegion = 3.
  """
  @spec sizeColumnRegion() :: integer
  def sizeColumnRegion() do
    sizeColumnRegion = 2
  end
end
