require 'rubygems'
gem 'minitest' # ensures we're using the gem, and not the built in MT

$:.unshift File.dirname(__FILE__) + "/../lib"

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require "mocha/setup"

require 'mundane-search'
require 'pry' rescue nil

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

      %w(mundane_search_initial_stack_path mundane_search_stack_path
         mundane_search_result_path generic_search_path
         mundane_search_result_model_path).each do  |path|
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

  def search_prefix
    "mundane_search_result_model"
  end
end

def requirements_for_simple_form!
  require 'active_support/concern'
  %w(form_options).each do |name|
    require "action_view/helpers/#{name}_helper"
  end
  require 'simple_form'
end