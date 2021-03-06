require 'rubygems'
gem 'minitest' # ensures we're using the gem, and not the built in MT

require 'coveralls'
require 'simplecov'

SimpleCov.start do
  coverage_dir 'tmp/coverage'
  add_filter   'spec'
end
Coveralls.wear!

$:.unshift File.dirname(__FILE__) + "/../lib"

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require 'mocha/setup'

require 'mundane-search'
require 'pry-debugger' rescue nil

class AgressiveBacktraceFilter < Minitest::BacktraceFilter
  def gem_paths
    return @gem_paths if @gem_paths
    raw_paths = `gem env gempath`
    @gem_paths = raw_paths.split(':')
  end

  def project_path
    @project_path ||= File.expand_path(File.dirname(__FILE__) + "/../")
  end

  def filter_paths
    gem_paths + [project_path]
  end

  def filter(bt)
    original_filter = super(bt)
    original_filter.collect do |line|
      filter_paths.inject(line) do |sum, path|
        sum.sub(/\A#{path}/,'')
      end
    end
  end
end

Minitest.backtrace_filter = AgressiveBacktraceFilter.new

# fail_fast hack
module Minitest
  class Unit
    def puke_with_immediate_feedback(klass, meth, e)
      # Workaround for minitest weirdness: When puke gets called *again* after
      # @exiting has been set to true down below, exit immediately so we don't
      # get an extra SystemExit stack trace.  Exiting without exclamation mark
      # doesn't get the non-zero exit code through, but all teardown handlers
      # have been run at this point, so it's OK to use a hard exit here.
      exit! 1 if @exiting_from_puke
      result = puke_without_immediate_feedback(klass, meth, e)
      unless e.is_a?(MiniTest::Skip)
        # Failure or Error, so print the report we just wrote and exit.
        puts "\n#{@report.pop}\n"
        @exiting_from_puke = true
        exit 1
      end
      result
    end
    # alias_method_chain :puke, :immediate_feedback
    alias_method :puke_without_immediate_feedback, :puke
    alias_method :puke, :puke_with_immediate_feedback
    
  end
end


def collection
  %w(foo bar baz)
end

def params
  { 'foo' => 'bar' }
end

def requirements_for_search_url_for_tests!
  require_relative 'demo_data'
  %w(capture url sanitize text form).each do |name|
    require "action_view/helpers/#{name}_helper"
  end
  require 'action_dispatch/routing/polymorphic_routes'
  require 'action_view/helpers/url_helper'

  def view_with_url_class
    Class.new do
      include ActionDispatch::Routing::PolymorphicRoutes
      include ActionView::Helpers::UrlHelper
      %w(generic_search_url).each do  |path|
        define_method path do |a=nil,b=nil|
          "/#{path}"
        end
      end
    end
  end
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
      include ActionView::RecordIdentifier

      %w(generic_search_path).each do  |path|
        define_method path do |a=nil,b=nil|
          "/#{path}"
        end
      end
      
      def polymorphic_path(*args)
        generic_search_path(*args)
      end

      attr_accessor :output_buffer
      def protect_against_forgery?
        false
      end
    end
  end

  def search_prefix
    "generic_search"
  end
end

def requirements_for_simple_form!
  require 'active_support/concern'
  %w(form_options).each do |name|
    require "action_view/helpers/#{name}_helper"
  end
  require 'simple_form'
end