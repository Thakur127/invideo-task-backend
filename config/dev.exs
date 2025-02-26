import Config

# Load environment variables from `.env`
# Dotenv.load()

# For development, we disable any cache and enable
# debugging and code reloading.
config :backend, BackendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "Ofgv1kncX7oPy0NQAe/Z21thO56sytfAxxvmWlCLgoUcQ9gAsnlgMROlQ5+svVKr",
  watchers: []

# Enable dev routes for dashboard and mailbox
config :backend, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Disable swoosh api client in development
config :swoosh, :api_client, false
