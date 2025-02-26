defmodule BackendWeb.RequestController do
  use BackendWeb, :controller

  alias Backend.AIClient

  def generate_webgl_code(conn, %{"input" => input}) do
    case AIClient.generate_webgl_code(input) do
      {:ok, response} ->
        if String.contains?(to_string(response), "Invalid Request") do
          conn
          |> put_status(400)
          |> json(%{status: "error", message: response})
        else
          conn
          |> put_status(200)
          |> json(%{status: "success", input: input, output: response})
        end

      {:error, error} ->
        if String.contains?(to_string(error), "Invalid Request") do
          conn
          |> put_status(400)
          |> json(%{status: "error", message: to_string(error)})
        else
          conn
          |> put_status(500)
          |> json(%{status: "error", message: "Something went wrong"})
        end
    end
  end
end
