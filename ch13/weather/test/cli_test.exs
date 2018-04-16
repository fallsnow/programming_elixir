defmodule CliTest do
  use ExUnit.Case
  doctest Weather

  import Weather.CLI, only: [parse_args: 1]

  test "help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["-help", "anything"]) == :help
  end

  test "the airport code is returned if an airport code is given" do
    assert parse_args(["KDTO"]) == {["KDTO"]}
  end
end
