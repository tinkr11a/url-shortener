defmodule UrlOperationsTest do
  @moduledoc false

  import AssertValue
  use ExUnit.Case
  alias UrlShortener.UrlOperations

  describe "sanitize" do
    @tag :url_operations
    @tag :url_operations_sanitize
    test "google.com" do
      input = "google.com"
      assert_value(UrlOperations.sanitize(input) == "google.com")
    end

    @tag :url_operations
    @tag :url_operations_sanitize
    test "www.google.com" do
      input = "www.google.com"
      assert_value(UrlOperations.sanitize(input) == "google.com")
    end

    @tag :url_operations
    @tag :url_operations_sanitize
    test "http://www.google.com" do
      input = "http://www.google.com"
      assert_value(UrlOperations.sanitize(input) == "google.com")
    end

    @tag :url_operations
    @tag :url_operations_sanitize
    test "https://www.google.com" do
      input = "https://www.google.com"
      assert_value(UrlOperations.sanitize(input) == "google.com")
    end

    @tag :url_operations
    @tag :url_operations_sanitize
    test "leading whitespace https://www.google.com/calendar?tab=mc&authuser=0" do
      input = "   https://www.google.com/calendar?tab=mc&authuser=0"

      assert_value(UrlOperations.sanitize(input) == "google.com/calendar?tab=mc&authuser=0")
    end

    @tag :url_operations
    @tag :url_operations_sanitize
    test "trailing whitespace https://www.google.com/calendar?tab=mc&authuser=0" do
      input = "https://www.google.com/calendar?tab=mc&authuser=0     "

      assert_value(UrlOperations.sanitize(input) == "google.com/calendar?tab=mc&authuser=0")
    end

    @tag :url_operations
    @tag :url_operations_sanitize
    test "invalid .com" do
      input = ".com"

      assert_value(UrlOperations.sanitize(input) == "com")
    end
  end

  describe "is_valid" do
    @tag :url_operations
    @tag :url_operations_is_valid
    test "google.com" do
      input = "google.com"

      assert_value(UrlOperations.is_valid?(input) == true)
    end

    @tag :url_operations
    @tag :url_operations_is_valid
    test "www.google.com" do
      input = "www.google.com"

      assert_value(UrlOperations.is_valid?(input) == true)
    end

    @tag :url_operations
    @tag :url_operations_is_valid
    test "http://google.com" do
      input = "http://google.com"

      assert_value(UrlOperations.is_valid?(input) == true)
    end

    @tag :url_operations
    @tag :url_operations_is_valid
    test "https://google.com" do
      input = "https://google.com"

      assert_value(UrlOperations.is_valid?(input) == true)
    end

    @tag :url_operations
    @tag :url_operations_is_valid
    test "https:/google.com" do
      # this test shows that validation function needs improvement
      input = "https:/google.com"

      assert_value(UrlOperations.is_valid?(input) == true)
    end

    @tag :url_operations
    @tag :url_operations_is_valid
    test "-google.com" do
      # this test shows that validation function needs improvement
      input = "-google.com"

      assert_value(UrlOperations.is_valid?(input) == true)
    end

    @tag :url_operations
    @tag :url_operations_is_valid
    test ".com" do
      # this test shows that validation function needs improvement
      input = ".com"

      assert_value(UrlOperations.is_valid?(input) == true)
    end

    @tag :url_operations
    @tag :url_operations_is_valid
    test "fdsklj" do
      input = "fdsklj"

      assert_value(UrlOperations.is_valid?(input) == false)
    end
  end
end
