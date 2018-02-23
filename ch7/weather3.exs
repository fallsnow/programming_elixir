defmodule WeatherHistory do
  
  def for_location([], _target_loc), do: []
  def for_location([ head = [_, target_loc, _,_ ] | tail], target_loc) do
    [ head | for_location(tail, target_loc) ]
  end
  def for_location([ _ | tail], target_loc), do: for_location(tail, target_loc)

  def test_data do
    [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 12, 0.25],
      [1366225622, 28, 10, 0.12],
      [1366225622, 29, 12, 0.135],
      [1366225622, 26, 35, 0.225],
      [1366225622, 27, 85, 0.175],
      [1366225622, 28, 18, 0.128],
      [1366225622, 29, 18, 0.325],
      [1366225622, 26, 25, 0.185],
      [1366225622, 27, 85, 0.105],
      [1366225622, 28, 18, 0.225],
    ]
  end

end
