defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.{Repo, User}

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, "show.html", user: user
  end

  def new(conn, params) do
    changeset = User.changeset(%User{}, params)
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "something went wrong")
        |> render("new.html", changeset: changeset)
    end
  end
end