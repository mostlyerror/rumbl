defmodule Rumbl.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name username)a)
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end

