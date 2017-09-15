defmodule FizzbuzCase do
  def upto(n) do
    Enum.map(1..n, &determine_word/1)
  end

  def determine_word(n) do
    case { rem(n, 3), rem(n, 5) } do
      { 0, 0 } ->
        "FizzBuzz"
      { _, 0 } ->
        "Buzz"
      { 0, _ } ->
        "Fizz"
      _ ->
        n
    end
  end
end
