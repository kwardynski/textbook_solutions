defmodule Rumbl.AccountsTest do
  use Rumbl.DataCase, async: true

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  describe "register_user/1" do
    @valid_attrs %{
      name: "User",
      username: "eva",
      password: "secret"
    }

    @invalid_attrs %{}
  end

  test "with valid data inserts user" do
    assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
    assert user.name == "User"
    assert user.username == "eva"
    assert [%User{id: ^id}] = Accounts.list_users()
  end
end
