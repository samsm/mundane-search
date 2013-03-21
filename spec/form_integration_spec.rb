require_relative 'minitest_helper'
requirements_for_form_for_tests!

describe "integration with Rails forms" do
  let(:built)  { MundaneSearch::Builder.new }
  let(:result) { built.result_for(open_struct_books, params)}

  describe "with Rails' form_for" do
    let(:formed) { formed_class.new }

    it "should convert to model" do
      formed.convert_to_model(result).must_equal result
    end

    it "should generate form from search result" do
      form = formed.form_for(result) { }
      form.must_match %r{<form}
    end

    it "should extract values from param_key for text_field accessors" do
      built.use MundaneSearch::Filters::AttributeMatch, param_key: 'title'
      form = formed.form_for(result) do |f|
        f.text_field :title
      end
      search_name = "mundane_search_result"
      form.must_match '<input id="mundane_search_result_title" name="mundane_search_result[title]" size="30" type="text" />'
    end
  end
end
