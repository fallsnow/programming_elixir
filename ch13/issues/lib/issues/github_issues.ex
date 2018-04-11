defmodule Issues.GithubIssues do
  require Logger
  
  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
  # use a module attribute to fetch the value at compile time
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    issues_url(user, project)
    # |> HTTPoison.get(@user_agent)
    # Add an option to get through a proxy
    |> HTTPoison.get(@user_agent, [{:proxy, "http://133.192.24.101:8080"}])
    |> handle_response
  end

  # def handle_response({ :ok, %{status_code: 200, body: body}}) do
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    {:ok, Poison.Parser.parse!(body)}
  end

  # def handle_response({ _, %{status_code: _, body: body}}) do
  #  { :error, body}
  def handle_response({_, %HTTPoison.Error{reason: reason}}) do
    Logger.error "Error #{reason} returned"
    {:error, reason}
  end

  # use a module attribute to fetch the value at compile time
  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end
end
