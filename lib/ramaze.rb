#          Copyright (c) 2008 Michael Fellinger m.fellinger@gmail.com
# All files in this distribution are subject to the terms of the Ruby license.

# StdLib
require 'abbrev'
require 'cgi'
require 'digest/md5'
require 'fileutils'
require 'ipaddr'
require 'optparse'
require 'ostruct'
require 'pathname'
require 'pp'
require 'set'
require 'socket'
require 'timeout'
require 'tmpdir'
require 'yaml'

begin
  require 'rubygems'
rescue LoadError
end

# Rack
require 'rack'
require 'rack/utils'
require 'rack/request'
require 'rack/response'

# The main namespace for Ramaze
module Ramaze
  BASEDIR = File.dirname(File.expand_path(__FILE__))
  $LOAD_PATH.unshift BASEDIR
  $LOAD_PATH.uniq!
end

Thread.abort_on_exception = true

# Bootstrap
require 'ramaze/version'
require 'ramaze/snippets'
require 'ramaze/log'
require 'ramaze/trinity'
require 'ramaze/current'
require 'ramaze/adapter'
require 'ramaze/option'
require 'ramaze/cache'
require 'ramaze/tool'

# Startup
require 'ramaze/controller'
require 'ramaze/sourcereload'

# Complete
require 'ramaze/dispatcher'
require 'ramaze/template/ezamar'
require 'ramaze/contrib'
require 'ramaze/route'

module Ramaze

  # Each of these classes will be called ::startup upon Ramaze.startup

  trait :essentials => [
    Global, Cache, Contrib, Controller, Session, SourceReload, Adapter
  ]

  class << self

    # The one place to start Ramaze, takes an Hash of options to pass on to
    # each class in trait[:essentials] by calling ::startup on them.

    def startup options = {}
      force = options.delete(:force)

      runner = options[:runner] ||= caller[0][/^(.*?):\d+/, 1]
      Global.merge!(options)

      if $0 == runner or force
        Log.info("Starting up Ramaze (Version #{VERSION})")

        trait[:essentials].each do |obj|
          obj.startup(options)
        end
      else
        Log.info "Ramaze already started, skipped start."
      end
    end

    # This will be called when you hit ^C or send SIGINT.
    # It sends ::shutdown to every class in trait[:essentials] and informs you
    # when it is done

    def shutdown
      trait[:essentials].each do |obj|
        obj.shutdown if obj.respond_to?(:shutdown)
      end

      puts("Shutdown Ramaze (it's safe to kill me now if i hang)")

      exit!
    end

    alias start startup
    alias stop shutdown
  end
end
