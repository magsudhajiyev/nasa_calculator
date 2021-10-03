defmodule NASACalc do
  def main do

    mass      = "Mass = " |> IO.gets() |> String.trim_trailing() |> String.to_integer()
    planet1   = "Launch = " |> IO.gets() |> String.trim_trailing() |> String.to_float()
    planet2   = "Land = " |> IO.gets() |> String.trim_trailing() |> String.to_float() 

    dests = [{:launch, planet1}, {:land, planet2}, {:launch, planet2}, {:land, planet1}]
    
    fuel_calculator(mass, dests)
  end

  def fuel_calculator(mass, destinations) do

    Enum.reduce(destinations, 0, fn destination, total_fuel -> 
      accumulated_mass = mass + total_fuel

      partial_fuel        = calculate(accumulated_mass, destination)
      partial_additional  = calculate(partial_fuel, destination, partial_fuel)

      total_fuel + partial_additional
    end)
  end

  defp calculate(partial_mass, destination, acc_fuel) do
    fuel = calculate(partial_mass, destination)

    cond do
      fuel <= 0 ->
        acc_fuel

      true ->
        calculate(fuel, destination, acc_fuel + fuel)
    end
  end

  def calculate(mass, destination) do
    case elem(destination, 0) do
      :launch -> launch(mass, elem(destination, 1))
      :land   -> land(mass, elem(destination, 1))
    end
  end
  
  defp launch(mass, gravity), do: floor(mass * gravity * 0.042 - 33)
  defp land(mass, gravity), do: floor(mass * gravity * 0.033 - 42)

end
