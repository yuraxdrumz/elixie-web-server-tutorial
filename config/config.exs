# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.
config :simple_server, 
  port: 4000,
  uri: "mongodb://localhost:27017/Dashboard",
  name: :mongo,
  log_level: :debug,
  issuer: "auth_me",
  secret_key: "" 

config :joken, default_signer: "56651dd8d2142f56a44a334f2180ec01d671d82f6b61e2b553d22381f6f017d9"

  # put the result of the mix command above here
# You can configure your application as:
#
#     config :simple_server, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:simple_server, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"
