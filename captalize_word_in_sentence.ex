defmodule Sentence do
  def capitalize(string_of_sentences) do
    split_sentences = String.split(string_of_sentences, ~r{\.\s})
    capitalized_words = Enum.map(split_sentences, &(String.capitalize(&1)))
    Enum.join(capitalized_words, ". ")
  end
end

    
