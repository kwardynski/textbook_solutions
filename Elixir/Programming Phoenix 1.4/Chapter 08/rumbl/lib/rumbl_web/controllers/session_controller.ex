defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  # Renders our login form
  def new(conn, _) do
    render(conn, "new.html")
  end

  # Handles for submissions
  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Rumbl.Accounts.authenticate_by_username_and_pass(username, password) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "Welcome Back")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
