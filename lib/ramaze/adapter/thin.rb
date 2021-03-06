require 'thin'
require 'rack/handler/thin'

module Ramaze
  module Adapter
    class Thin < Base
      class << self

        # start server on given host and port.
        def run_server host, port
          server = ::Thin::Server.new(host, port, self)
          ::Thin::Logging.silent = true
          server.timeout = 3

          thread = Thread.new{ server.start }
          thread[:adapter] = server
          thread
        end
      end
    end
  end
end
