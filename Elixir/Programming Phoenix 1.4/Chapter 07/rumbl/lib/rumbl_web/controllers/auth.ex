defmodule RumblWeb.Auth do
  import Phoenix.Controller
  import Plug.Conn
  alias RumblWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Rumbl.Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end


  # Configure_session(renew: true) protects us from session fixation attacks
  # It tells Plug to send the session cookie back to the client with a different identifier,
  # in case an attacker knew the previous one
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  # If there is a current user, we return the connection unchanged
  # Otherwise - store a flash message and redirect back to the application root.
  # halt(conn) stops any downstream transformations.
  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

end
