defmodule WeirdEnum do

  def all?(list, function) do
    _all?(list, function)
  end

  def _all?([], _), do: true

  def _all?([head|tail], function) do
    if function.(head) == true do
      _all?(tail, function)
    else
      false
    end
  end

  def any?(list, function) do
    _any?(list, function)
  end

  def _any?([], _), do: false

  def _any?([head|tail], function) do
    if function.(head) == true do
      true
    else
      _any?(tail, function)
    end
  end

  def each(list, function) do
    _each(list, function)
  end

  def _each([], _), do: nil

  def _each([head|tail], function) do
    IO.puts "#{function.(head)}"
    _each(tail, function)
  end

  def reverse(list) do
    _reverse(list)
  end

  def _reverse(_, acc \\ [])

  def _reverse([], acc), do: acc

  def _reverse([head|tail], acc) do
    acc = [ head | acc ]
    _reverse(tail, acc)
  end

  def filter(list, function) do
    _filter(list, function)
  end

  def _filter(_, _, acc \\ [])

  def _filter([], _, acc) do
    reverse(acc)
  end

  def _filter([head|tail], function, acc) do
    acc = if function.(head) == true do
            [ head | acc ]
          else
            acc
          end
    _filter(tail, function, acc)
  end

  def split(list, count) do
    _split(list, count)
  end

  def _split(_, _, acc \\ [])

  def _split(tail, 0, acc), do: { reverse(acc), tail }

  def _split([head|tail], count, acc) do
    acc = [ head | acc ]
    count = count - 1
    _split(tail, count, acc)
  end

  def take(list, count) do
    _take(list, count)
  end

  def _take(_, _, acc \\ [])

  def _take(_, 0, acc) do
    reverse(acc)
  end

  def _take([head|tail], count, acc) when count > 0 do
    acc = [ head | acc ]
    count = count - 1
    _take(tail, count, acc)
  end
end
