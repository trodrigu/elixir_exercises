defmodule AProcess do
  def return_token(token) do
    receive do
      {sender, message} ->
        send sender, {:ok, token}
    end
  end
end

pid1 = spawn(AProcess, :return_token, [:fred])
pid2 = spawn(AProcess, :return_token, [:betty])

send pid1, { self, "yo" }
send pid2, { self, "hey" }

receive do
  {:ok, :fred} ->
    IO.inspect :fred
end

receive do
  {:ok, :betty} ->
    IO.inspect :betty
end
