defmodule RouterTest do
  @moduledoc false

  use ExUnit.Case
  use Plug.Test
  import Mock

  @options UrlShortener.Router.init([])

  defp repo_mock do
    {UrlShortener.Repo, [],
     [
       get: fn _module, _id -> %{id: 5} end,
       get_by: fn _module, _prop -> %{id: 5} end,
       insert: fn _module, _model -> {:ok, %{id: 5}} end
     ]}
  end

  @tag :router
  test "alive" do
    result = conn(:get, "/alive") |> UrlShortener.Router.call(@options)

    assert(result.resp_body == "1")
  end

  @tag :router
  describe "create short url" do
    test "- no url" do
      result = conn(:get, "/short_url") |> UrlShortener.Router.call(@options)

      assert(result.status == 422)
    end

    test "- url in query params" do
      with_mocks([repo_mock()]) do
        result =
          conn(:get, "/short_url", %{url: "www.google.com"}) |> UrlShortener.Router.call(@options)

        assert(result.status == 200)

        assert(
          result.resp_body |> Poison.decode!(keys: :atoms) |> Map.get(:short_url) ==
            "http://localhost:4001/5"
        )
      end
    end
  end

  describe "redirect" do
    test "- non_existing url can't redirect" do
      with_mocks([repo_mock()]) do
        result = conn(:get, "/null") |> UrlShortener.Router.call(@options)

        assert(result.status == 204)

        assert(
          result.resp_body
          |> Poison.decode!(keys: :atoms)
          |> Map.get(:message) ==
            "Url not found"
        )
      end
    end
  end
end
