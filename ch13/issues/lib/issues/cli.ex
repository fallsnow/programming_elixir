defmodule Issues.CLI do

  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the variou functions taht end up generating a
  table of the last _n_ issues in a github project
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of intries to format.

  Return a tuple of `{ user, project, count}`, or `:help` if help was given.
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases:  [ h:    :help    ])

    case parse do

    { [ help: true ], _, _ }
      -> :help

    { _, [ user, project, count ], _ }
      -> { user, project, 
           String.to_integer(count) }

    { _, [ user, project ], _ }
      -> { user, project, @default_count }

    _ -> :help

    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_list_of_maps
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> show_in_tabular
    #|> show_in_tabular
    #|> Enum.find(fn(x) -> x["number"] == 6768 end)
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:eror, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def convert_to_list_of_maps(list) do
    list
    |> Enum.map(&Enum.into(&1, Map.new))
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues, fn i1, i2 -> i1["created_at"] <= i2["created_at"] end
  end

  def show_in_tabular(issues) do
    IO.puts "#     | Created at        | Title"
    IO.puts "------+-------------------+---------------------------------------"
    issues
    |> Enum.map(fn(x) -> IO.puts "#{x["number"]} | #{x["created_at"]} | #{x["title"]}" end)
  end
end
