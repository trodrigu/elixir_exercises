defmodule Parallel do
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
         spawn_link fn -> (send me, { self, fun.(elem) }) end
       end)
    |> Enum.map(fn (pid) ->
         receive do { ^pid, result } -> result end
       end)
  end
end
import :timer, only: [ sleep: 1 ]
result = Parallel.pmap(1..10, fn
                        5 ->
                          sleep 500
                          5 * 5
                        x -> x * x end)
IO.inspect result
