require_relative 'minitest_helper'

requirements_for_form_for_tests!
requirements_for_simple_form!

describe "integration simple_search_form_for" do
  let(:result_class) { Class.new(MundaneSearch::Result) }
  let(:result) { result_class.new(open_struct_books, params) }
  let(:result_model) { result.to_model }
  let(:search_formed_class) do
    Class.new(formed_class) do
      include MundaneSearch::ViewHelpers
      include SimpleForm::ActionViewExtensions::FormHelper

      # In simple_form, FormBuilder in lookup_action asks controller for action
      def controller ; OpenStruct.new(action: :create) ; end
    end
  end
  let(:formed) { search_formed_class.new }

  it "should generate form with method=get" do
    form = formed.simple_search_form_for(result_model) { }
    form.must_match %r{<form[^>]+method="get"}
  end
end
