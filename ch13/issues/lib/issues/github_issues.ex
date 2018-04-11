defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
  # use a module attribute to fetch the value at compile time
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    # |> HTTPoison.get(@user_agent)
    # Add an option to get through a proxy
    issues_url(user, project)
    |> HTTPoison.get(@user_agent, [{:proxy, "http://133.192.24.101:8080"}])
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  # def handle_response({ :ok, %{status_code: 200, body: body}}) do
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  # def handle_response({ _, %{status_code: _, body: body}}) do
  #  { :error, body}
  def handle_response({_, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
