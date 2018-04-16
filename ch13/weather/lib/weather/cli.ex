defmodule Weather.CLI do
  import Weather.TableFormatter, only: [print_table_for_columns: 2]

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse =
      OptionParser.parse(
        argv,
        switches: [help: :boolean],
        aliases: [h: :help]
      )

    case parse do
      {[help: true], _, _} ->
        :help

      {_, airport, _} ->
        {airport}

      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weather <airport code>
    """
    System.halt(0)
  end

  def process({airport}) do
    Weather.NoaaObservations.fetch(airport)
    |> print_table_for_columns(["station_id", "location", "temp_c"])
  end
end
