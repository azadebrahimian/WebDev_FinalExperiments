defmodule ExperimentWeb.IngredientController do
  use ExperimentWeb, :controller

  alias Experiment.Ingredients
  alias Experiment.Ingredients.Ingredient

  def index(conn, _params) do
    ingredients = Ingredients.list_ingredients()
    render(conn, "index.html", ingredients: ingredients)
  end

  def new(conn, _params) do
    changeset = Ingredients.change_ingredient(%Ingredient{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    case Ingredients.create_ingredient(ingredient_params) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient created successfully.")
        |> redirect(to: Routes.ingredient_path(conn, :show, ingredient))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ingredient = Ingredients.get_ingredient!(id)
    render(conn, "show.html", ingredient: ingredient)
  end

  def edit(conn, %{"id" => id}) do
    ingredient = Ingredients.get_ingredient!(id)
    changeset = Ingredients.change_ingredient(ingredient)
    render(conn, "edit.html", ingredient: ingredient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ingredient" => ingredient_params}) do
    ingredient = Ingredients.get_ingredient!(id)

    case Ingredients.update_ingredient(ingredient, ingredient_params) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient updated successfully.")
        |> redirect(to: Routes.ingredient_path(conn, :show, ingredient))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ingredient: ingredient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ingredient = Ingredients.get_ingredient!(id)
    {:ok, _ingredient} = Ingredients.delete_ingredient(ingredient)

    conn
    |> put_flash(:info, "Ingredient deleted successfully.")
    |> redirect(to: Routes.ingredient_path(conn, :index))
  end
end
