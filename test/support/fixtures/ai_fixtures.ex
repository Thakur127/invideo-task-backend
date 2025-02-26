defmodule Backend.AIFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.AI` context.
  """

  @doc """
  Generate a request.
  """
  def request_fixture(attrs \\ %{}) do
    {:ok, request} =
      attrs
      |> Enum.into(%{
        input: "some input",
        output: "some output"
      })
      |> Backend.AI.create_request()

    request
  end
end
