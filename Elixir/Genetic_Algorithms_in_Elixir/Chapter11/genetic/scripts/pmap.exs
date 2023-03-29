expensive = fn x ->
  x = x * x
  :timer.sleep(500)
  x
end

inexpensive = fn x -> x * x end

data = for x <- 1..100, do: x

Benchee.run(%{
  "pmap, expensive" => fn -> Genetic.pmap(data, &(expensive.(&1))) end,
  "pmap, inexpensive" => fn -> Genetic.pmap(data, &(inexpensive.(&1))) end,
  "map, expensive" => fn -> Enum.map(data, &(expensive.(&1))) end,
  "map, inexpensive" => fn -> Enum.map(data, &(inexpensive.(&1))) end
  }, memory_time: 7)
