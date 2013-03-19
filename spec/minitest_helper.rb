require 'rubygems'
gem 'minitest' # ensures you're using the gem, and not the built in MT
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'

require 'mundane-search'
require 'pry' rescue nil

class NothingFilterForTest
  def initialize(a=nil) ; end
  def call(c,p) ; [c,p] ; end
end

def collection
  %w(foo bar baz)
end

def params
  { 'foo' => 'bar' }
end
