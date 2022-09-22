defmodule HelloWeb.HelloController do

  # This prepares us to use the Phoenix Controller API
  use HelloWeb, :controller

  # def world(conn, _params) do
  #   render(conn, "world.html")
  # end

  def world(conn, %{"name" => name}) do
    render(conn, "world.html", name: name)
  end
end
