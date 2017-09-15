defmodule StringsAndBinaries7 do
  def read_path(path) do
    {:ok, file} = File.open(path, [:read])
    data = Enum.map(IO.stream(file, :line), fn line -> process_line(line) end)
    File.close(file)
  end

  def process_line("id,ship_to,amount") do
  end

  def process_line(line) do
    row_array = String.split(line)
    [id, state, amount] = Enum.map(row_array, &String.trim/1)
    [String.to_integer(id), String.to_atom(state), String.to_float(amount)]
  end
end
