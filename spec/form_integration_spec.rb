require_relative 'minitest_helper'
requirements_for_form_for_tests!

describe "integration with Rails forms" do
  let(:result_class) { Class.new(MundaneSearch::Result) }
  let(:result) { result_class.new(open_struct_books, params) }
  let(:result_model) { result.to_model }

  describe "with Rails' form_for" do
    let(:formed) { formed_class.new }

    it "should convert to model" do
      formed.convert_to_model(result).must_equal result.to_model
    end

    it "should generate form from search result" do
      form = formed.form_for(result) { }
      form.must_match %r{<form}
    end

    it "should extract values from param_key for text_field accessors" do
      result_class.builder.use MundaneSearch::Filters::AttributeMatch, key: 'title'
      form = formed.form_for(result_model) do |f|
        f.text_field :title
      end
      form.must_match %{<input id="#{search_prefix}_title" name="#{search_prefix}[title]" size="30" type="text" />}
    end
  end
end
