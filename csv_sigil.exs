defmodule CSVSigil do
  @doc """
  Implement the `~v` sigil, which takes a string containing
  multiple lines and returns a list of those as Lists of column data.

  ## Example usage

    iex> import CSVSigil
    iex> ~v\"""
    ...> 1,2,3
    ...> cat,dog
    ...> \"""
    [["1","2","3"],["cat","dog"]]
  """

  def sigil_v(data, _opts) do
    data_split_up =
      data
      |> String.rstrip
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, ",") end)
      |> Enum.map(&cast/1)
    [head|tail] = data_split_up
    atom_keys = Enum.map(head, fn x -> String.to_atom(x) end)
    tail
    |> Enum.map(fn x -> Enum.zip(atom_keys, x) end)
    |> IO.inspect
  end

  def cast(list) do
    _cast(list)
  end

  defp _cast(_, acc \\ [])
  defp _cast([], acc), do: acc
  defp _cast([head|tail], acc) do
    new_acc = case Float.parse(head) do
                :error ->
                  [head|acc]
                {value, _} ->
                  [value|acc]
              end
    _cast(tail, new_acc)
  end
end
import CSVSigil
~v"""
Item,Amount,Price
chicken,2,$3
beef,1,$2
"""
