defmodule Backend.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :input, :string
      add :output, :string

      timestamps(type: :utc_datetime)
    end
  end
end
