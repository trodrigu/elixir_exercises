defmodule Format do

  def anagram?(word1, word2) do
    word1_list_chars = make_into_list_chars(word1)
    word2_list_chars = make_into_list_chars(word2)    
    word1_list_chars_total = find_list_chars_total(word1_list_chars)
    word2_list_chars_total = find_list_chars_total(word2_list_chars)
    word1_list_chars_total == word2_list_chars_total
  end

  def make_into_list_chars(word) do
    for char <- (String.codepoints word), <<integer::utf8>> = char, do: integer
  end

  def find_list_chars_total(list) do
    List.foldl(list, 0, fn(x, acc) -> x + acc end)
  end
end
    
