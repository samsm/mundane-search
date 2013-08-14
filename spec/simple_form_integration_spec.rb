require_relative 'minitest_helper'

requirements_for_form_for_tests!
requirements_for_simple_form!

describe "intgration with simple_form" do
  let(:result_class) { Class.new(MundaneSearch::Result) }
  let(:result) { result_class.new(open_struct_books, params) }
  let(:result_model) { result.to_model }

  let(:simple_formed_class) do
    Class.new(formed_class) do
      include SimpleForm::ActionViewExtensions::FormHelper

      # In simple_form, FormBuilder in lookup_action asks controller for action
      def controller ; OpenStruct.new(action: :create) ; end
    end
  end
  let(:formed) { simple_formed_class.new }

  it "should generate simple_form" do
    form = formed.simple_form_for(result) { }
    form.must_match %r{<form}
  end

  it "should determine input" do
    result_class.builder.use MundaneSearch::Filters::AttributeMatch, key: 'title'
    form = formed.simple_form_for(result_model) do |f|
      f.input :title
    end
    match_tag = form.match(%{<input[^>]*id="#{search_prefix}_title"[^>]*/>})
    match_tag[0].must_match %{name="#{search_prefix}[title]"}
  end
end
