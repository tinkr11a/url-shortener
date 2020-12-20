Application.ensure_all_started(:assert_value)
Application.ensure_all_started(:telemetry)
DeferredConfig.populate(:url_shortener)
ExUnit.start()
