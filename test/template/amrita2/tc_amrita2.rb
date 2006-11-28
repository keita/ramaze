require 'ramaze'
require 'test/test_helper'

include Ramaze

class MainController < Template::Amrita2
  def title
    "hello world"
  end

  def body
    "Amrita2 is an HTML template library for Ruby"
  end
end

start :mode => :debug

context "Simply calling" do
  def request opt
    open("http://localhost:#{Ramaze::Global.port}/#{opt}").read
  end

  specify "should respond to /data" do
    request('/data')                               # =>
  end
end