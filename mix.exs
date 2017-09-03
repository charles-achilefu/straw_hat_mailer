defmodule StrawHat.Mailer.Mixfile do
  use Mix.Project

  @elixir_version "~> 1.5"
  @name :straw_hat_mailer
  @organization "straw_hat"
  @version "0.0.1"
  @description """
    Mailer Management
  """
  @source_url "https://github.com/straw-hat-llc/straw_hat_mailer"

  def project do
    production? = Mix.env == :prod

    [
     app: @name,
     description: @description,
     version: @version,
     elixir: @elixir_version,
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: production?,
     start_permanent: production?,
     deps: deps(),
     aliases: aliases(),
     package: package(),

      # docs
      name: "StrawHat.mailer",
      source_url: @source_url,
      homepage_url: @source_url,
      docs: [
        main: "StrawHat.Mailer",
        extras: ["README.md"]
      ],

      # coverage
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      mod: {StrawHat.Mailer.Application, []},
      extra_applications: [
        :logger,
        :swoosh,
        :gen_smtp
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:postgrex, "~> 0.13.2"},
      {:ecto, "~> 2.1"},
      {:scrivener_ecto, "~> 1.2"},

      {:swoosh, "~> 0.8.0"},
      {:gen_smtp, "~> 0.11.0"},

      # Testing
      {:ex_machina, ">= 0.0.0", only: :test},
      {:faker, ">= 0.0.0", only: :test},

      # Tools
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.0.0", only: :test}
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end

  defp package do
    [
      name: @name,
      organization: @organization,
      files: [
        "lib",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: ["Osley Zorrilla"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end