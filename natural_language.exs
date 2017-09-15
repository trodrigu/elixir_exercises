defmodule LengthModule do

  #defmacro explain(expr) do
  defmacro defmodule_with_length(name, do: block) do
    expanded = Macro.expand(name, __CALLER__)
    expanded |> IO.inspect
    length = length(Atom.to_charlist(expanded))

    quote do
      defmodule unquote(name) do
        def name_length, do: unquote(length)
        unquote(block)
      end
    end
  end
end

defmodule NaturalLanguage do

  defmacro explain(expr) do
    do_expr= Keyword.get(expr, :do)
    grab_operators_and_numbers(do_expr)
      |> IO.inspect
  end

  def grab_operators_and_numbers(expr) do
    case expr do
      {:+, _, [number_1, {:*, _, [number_2, number_3]}]} ->
        "Multiply #{number_2} and #{number_3}, then add #{number_1}"

      {:-, _, [number_1, {:*, _, [number_2, number_3]}]} ->
        "Multiply #{number_2} and #{number_3}, then subtract #{number_1}"

      {:*, _, [number_1, {:+, _, [number_2, number_3]}]} ->
        "Multiply #{number_1} and #{number_2}, then add #{number_1}"

      {:*, _, [number_1, {:-, _, [number_2, number_3]}]} ->
        "Multiply #{number_1} and #{number_2}, then subtract #{number_1}"

      {:+, _, [number_1, {:-, _, [number_2, number_3]}]} ->
        "Add #{number_1} and #{number_2}, then add #{number_3}"

      {:-, _, [number_1, {:-, _, [number_2, number_3]}]} ->
        "Subtract #{number_1} and #{number_2}, then subtract #{number_3}"

      {:-, _, [{:+, _, [number_1, number_2]}, number_3]} ->
        "Add #{number_1} and #{number_2}, then minus #{number_3}"

      {:-, _, [{:-, _, [number_1, number_2]}, number_3]} ->
        "Subtract #{number_1} and #{number_2}, then minus #{number_3}"

      {:*, _, [{:*, _, [number_1, number_2]}, number_3]} ->
        "Multiply #{number_1} and #{number_2}, then multiply #{number_3}"

      {:-, _, [{:*, _, [number_1, number_2]}, number_3]} ->
        "Multiply #{number_1} and #{number_2}, then minus #{number_3}"

      {:+, _, [{:*, _, [number_1, number_2]}, number_3]} ->
        "Multiply #{number_1} and #{number_2}, then add #{number_3}"

      {:+, _, [{:-, _, [number_1, number_2]}, number_3]} ->
        "Subtract #{number_1} and #{number_2}, then add #{number_3}"

      {:+, _, [{:+, _, [number_1, number_2]}, number_3]} ->
        "Add #{number_1} and #{number_2}, then add #{number_3}"
      _ ->
        "I don\'t understand"
    end
  end
end

defmodule Test do
  import NaturalLanguage
  explain do: 4 + 9 * 4
end
