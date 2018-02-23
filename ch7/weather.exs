defmodule WeatherHistory do
  
  def for_location_27([]), do: []
  def for_location_27([ [time, 27, temp, rain ] | tail]) do
    [ [time, 27, temp, rain] | for_location_27(tail) ]
  end
  def for_location_27([ _ | tail]), do: for_location_27(tail)

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
