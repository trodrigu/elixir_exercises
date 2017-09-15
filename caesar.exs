defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    charlist = String.to_charlist(string)
    shifted_charlist = Enum.map(charlist, fn x -> x + shift end)
    List.to_string(shifted_charlist)
  end

  def rot13(string) do
    charlist = String.to_charlist(string)
    shifted_charlist = Enum.map(charlist, fn x -> x + 13 end)
    List.to_string(shifted_charlist)
  end

  def match_rot13?(string, word_bank) do
    Enum.member?(rot13(string), word_bank)
  end
end

defimpl Caesar, for: List do
  def encrypt(charlist, shift) do
    Enum.map(charlist, fn x -> x + shift end)
  end

  def rot13(charlist) do
    Enum.map(charlist, fn x -> x + 13 end)
  end

  def match_rot13?(charlist, word_bank) do
    Enum.member?(rot13(charlist), word_bank)
  end
end

defmodule SearchForRot13 do

  def files do
    with {:ok, files} <- File.ls("/Users/trodrigu/Downloads/scowl-2017.01.22/final"), do: files
  end

  def read_file(file_path) do
    File.read! file_path
  end

  def build_word_bank do
    iterate_through_files(files)
  end

  def iterate_through_files(_, acc \\ [])

  def iterate_through_files([], acc), do: IO.puts(Enum.count(acc))

  def iterate_through_files([head|tail], acc) do
    words = get_words(head)
    acc = Enum.into(acc, words)
    iterate_through_files(tail, acc)
  end

  def get_words_calc(file) do
    file_path = "/Users/trodrigu/Downloads/scowl-2017.01.22/final/" <> file
    new_read_file = read_file(file_path)
    String.split(new_read_file)
    |> Enum.filter(fn x -> String.length(x) < 6 end)
    |> Enum.filter(fn x -> String.valid?(x) end)
  end

  def get_words(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:get_words, file, client} ->
        send client, {:answer, get_words_calc(file), self}
        get_words(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:get_words, next, self}
        schedule_processes(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn n1, n2 -> n1 <= n2 end)
        end
      {:answer, result, _pid} ->
        schedule_processes(processes, queue, Enum.into(results, result))
    end
  end
end

# IO.puts inspect :timer.tc(SearchForRot13, :build_word_bank, [])
files = SearchForRot13.files
num_processes = Enum.count(files)
{time, words} = :timer.tc(Scheduler, :run, [num_processes, SearchForRot13, :get_words, files])
words
|> Enum.count
|> IO.puts

weird_words =
  words
  |> Enum.filter(fn x -> Enum.member?(words, Caesar.rot13(x)) end)
IO.puts(Enum.count(weird_words))
weirder_words = Enum.slice(weird_words, -10..-1)
weirder_words
|> IO.inspect
