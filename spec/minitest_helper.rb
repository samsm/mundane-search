require 'rubygems'
gem 'minitest' # ensures you're using the gem, and not the built in MT

$:.unshift File.dirname(__FILE__) + "/../lib"

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require "mocha/setup"

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

def requirements_for_form_for_tests!
  require_relative 'demo_data'
  require 'active_support/concern'
  %w(capture url sanitize text form).each do |name|
    require "action_view/helpers/#{name}_helper"
  end
  require 'action_controller/record_identifier'
  require 'action_view'
  def formed_class
    Class.new do
      include ActionView::Helpers::FormHelper
      include ActionController::RecordIdentifier

      %w(mundane_search_initial_result_path mundane_search_result_path).each do  |path|
        define_method path do |a,b|
          "/#{path}"
        end
      end

      attr_accessor :output_buffer
      def protect_against_forgery?
        false
      end
    end
  end
end

def requires_for_simple_form!
  require 'active_support/concern'
  %w(form_options).each do |name|
    require "action_view/helpers/#{name}_helper"
  end
  require 'simple_form'
end