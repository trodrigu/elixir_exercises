defmodule Format do

  def ascii?(list) do
    _check_ascii(list)
  end

  defp _check_ascii([]), do: true

  defp _check_ascii([ head | tail ]) when head in 32..126 do
    _check_ascii(tail)
  end

  defp _check_ascii(_) do
    false
  end
end
