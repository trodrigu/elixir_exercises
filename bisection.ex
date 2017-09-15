defmodule Chop do

  def guess(actual, current_guess) when current_guess == actual do
    current_guess
  end

  def guess(actual, range) do
    current_guess = make_guess(range)
    IO.puts "Is it #{current_guess}"
    range = adjust_bounds(actual, range, current_guess)
    guess(actual, range)
  end

  def adjust_bounds(actual, _, current_guess) when actual == current_guess do
    current_guess
  end

  def adjust_bounds(actual, range, current_guess) when actual < current_guess do
    first.._ = range
    first..current_guess
  end

  def adjust_bounds(actual, range, current_guess) when actual > current_guess do
    _..last = range
    current_guess..last
  end

  def make_guess(range) do
    first..last = range
    difference = abs(first - last)
    guess = first + div(difference, 2)
    guess
  end
end
