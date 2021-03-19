defmodule Experiment.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :ingredient_name, :string

      timestamps()
    end

  end
end
