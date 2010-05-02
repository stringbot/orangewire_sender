module Orangewire
  class Base < RuntimeError; end
  class ConfigError < Base; end
  class ConnectionError < Base; end
end