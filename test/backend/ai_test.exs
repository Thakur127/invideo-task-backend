defmodule Backend.AITest do
  use Backend.DataCase

  alias Backend.AI

  describe "requests" do
    alias Backend.AI.Request

    import Backend.AIFixtures

    @invalid_attrs %{input: nil, output: nil}

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert AI.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert AI.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      valid_attrs = %{input: "some input", output: "some output"}

      assert {:ok, %Request{} = request} = AI.create_request(valid_attrs)
      assert request.input == "some input"
      assert request.output == "some output"
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AI.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      update_attrs = %{input: "some updated input", output: "some updated output"}

      assert {:ok, %Request{} = request} = AI.update_request(request, update_attrs)
      assert request.input == "some updated input"
      assert request.output == "some updated output"
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = AI.update_request(request, @invalid_attrs)
      assert request == AI.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = AI.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> AI.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = AI.change_request(request)
    end
  end
end
