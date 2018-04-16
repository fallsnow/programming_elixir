defmodule Weather.NoaaObservations do
  @user_agent [ {"User-agent", "Elixir dave@pragprog.com"} ]
  @noaa_url Application.get_env(:weather, :noaa_url)

  def fetch(airport) do
    issues_url(airport)
    #|> HTTPoison.get(@user_agent, [{:proxy, "http://133.192.24.101:8080"}])
    |> HTTPoison.get([{:proxy, "http://133.192.24.101:8080"}])
    |> handle_response
    |> get_weather_info
  end

  def issues_url(airport) do
    "#{@noaa_url}/#{airport}.xml"
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    #Logger.info "Successful response"
    #Logger.debug fn -> inspect(body) end
    #{:ok, Poison.Parser.parse!(body)}
    #{:ok, body}
    body
  end

  def handle_response({_, %HTTPoison.Error{reason: reason}}) do
    #Logger.error "Error #{reason} returned"
    {:error, reason}
  end

  def get_weather_info(xml) do
    %{}
    |> Map.merge(Regex.named_captures(~r/<station_id>(?<station_id>.+)<\/station_id>/, xml))
    |> Map.merge(Regex.named_captures(~r/<location>(?<location>.+)<\/location>/, xml))
    |> Map.merge(Regex.named_captures(~r/<temp_c>(?<temp_c>.+)<\/temp_c>/, xml))
  end

end
