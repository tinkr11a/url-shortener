defmodule ConverterTest do
  @moduledoc false

  use ExUnit.Case
  import AssertValue
  import Mock

  alias UrlShortener.Converter

  defp repo_mock do
    {UrlShortener.Repo, [],
     [
       get: fn
         _model, 55 -> %{id: 55, long: "sample.com"}
         _model, _id -> nil
       end,
       get_by: fn
         _model, [long: "sample.com"] -> %{id: 55, long: "sample.com"}
         _model, [long: "other-sample.com"] -> %{id: 66, long: "other-sample.com"}
         _model, [long: long] -> %{id: 67, long: long}
       end,
       insert: fn model -> model |> Map.put(:id, 56) end
     ]}
  end

  describe "to_long" do
    @tag :converter
    @tag :converter_to_long
    test "t (55) - exsisting item" do
      with_mocks([repo_mock()]) do
        result = Converter.to_long("t")

        assert_value(result == {:ok, "http://sample.com"})
      end
    end

    @tag :converter
    @tag :converter_to_long
    test "b - non exsisting item" do
      with_mocks([repo_mock()]) do
        result = Converter.to_long("b")

        assert_value(result == {:error, "Url not found"})
      end
    end
  end

  describe "to_short" do
    @tag :converter
    @tag :converter_to_short
    test "sample.com" do
      with_mocks([repo_mock()]) do
        result = Converter.to_short("sample.com")

        assert_value(result == {:ok, "http://localhost:4001/t"})
      end
    end

    @tag :converter
    @tag :converter_to_short
    test "www.sample.com" do
      with_mocks([repo_mock()]) do
        result = Converter.to_short("www.sample.com")

        assert_value(result == {:ok, "http://localhost:4001/t"})
      end
    end

    @tag :converter
    @tag :converter_to_short
    test "http://sample.com" do
      with_mocks([repo_mock()]) do
        result = Converter.to_short("http://sample.com")

        assert_value(result == {:ok, "http://localhost:4001/t"})
      end
    end

    @tag :converter
    @tag :converter_to_short
    test "https://sample.com" do
      with_mocks([repo_mock()]) do
        result = Converter.to_short("https://sample.com")

        assert_value(result == {:ok, "http://localhost:4001/t"})
      end
    end

    @tag :converter
    @tag :converter_to_short
    test "http://www.sample.com" do
      with_mocks([repo_mock()]) do
        result = Converter.to_short("http://www.sample.com")

        assert_value(result == {:ok, "http://localhost:4001/t"})
      end
    end

    @tag :converter
    @tag :converter_to_short
    test "other-sample.com" do
      with_mocks([repo_mock()]) do
        result = Converter.to_short("other-sample.com")

        assert_value(result == {:ok, "http://localhost:4001/14"})
      end
    end

    @tag :converter
    @tag :converter_to_short
    test "my-sample.com" do
      with_mocks([repo_mock()]) do
        result = Converter.to_short("my-sample.com")

        assert_value(result == {:ok, "http://localhost:4001/15"})
      end
    end
  end
end
