require_relative 'minitest_helper'

requirements_for_search_url_for_tests!

describe "integration search_url_for" do
  let(:result_class) { Class.new(MundaneSearch::Result) }
  let(:result) { result_class.new(open_struct_books, params) }
  let(:result_model) { result.to_model }
  let(:search_url_viewed_class) do
    Class.new(view_with_url_class) do
      include MundaneSearch::ViewHelpers
    end
  end
  let(:search_url_view) { search_url_viewed_class.new }

  it "should generate url" do
    form = search_url_view.search_url_for(result_model) { }
    form.must_match %r{\A/}
  end

  it "should generate link" do
    form = search_url_view.search_link_for("anchor", result_model) { }
    form.must_match %r{\A<a}
  end

  it "should add class 'unchanged-search' when search object isn't changed" do
    form = search_url_view.search_link_for("anchor", result_model) { }
    form.must_match %r{class="unchanged-search"}
  end

  it "should not class 'unchanged-search' when search object isn't changed" do
    form = search_url_view.search_link_for("anchor", result_model, {"foo" => "something else"}) { }
    form.wont_match %r{class="unchanged-search"}
  end
end
