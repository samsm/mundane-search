requirements_for_form_for_tests!
requires_for_simple_form!

describe "intgration with simple_form" do
  let(:built)  { MundaneSearch::Builder.new }
  let(:result) { built.result_for(open_struct_books, params)}
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
    built.use MundaneSearch::Filters::AttributeMatch, param_key: 'title'
    form = formed.simple_form_for(result) do |f|
      f.input :title
    end
    form.must_match '<input class="string required" id="mundane_search_result_title" name="mundane_search_result[title]" required="required" size="50" type="text" />'
  end
end

