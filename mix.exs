defmodule Ants.Mixfile do
  use Mix.Project

  def project do
    [app: :ants,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:httpotion, :eden, :logger]]
  end

  defp deps do
    [
      {:eden, github: "felipesere/Eden"},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:httpotion, "~> 2.1.0"}
    ]
  end
end
