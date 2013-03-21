require_relative 'minitest_helper'

describe ColumnsHash do
  [:binary, :boolean, :date, :datetime, :decimal, :float, :integer, :primary_key, :string, :text, :time, :timestamp].each do |type|
    it "should respond to all ActiveRecord type #{type}" do
      ColumnsHash.generate({type: type}).must_be_kind_of ColumnsHash::Attribute
    end
  end

  it "should have 255 limit when string" do
    ColumnsHash.generate({type: :string}).limit.must_equal 255
  end

  [:float, :integer].each do |type|
    it "should be number? true when #{type}" do
      ColumnsHash.generate({type: type}).number?.must_equal true
    end
  end

  describe "applied to class" do
    before do
      @with_columns = Class.new do
        include ColumnsHash
      end.new
    end

    it "should have a columns_hash" do
      @with_columns.columns_hash.must_be_kind_of Hash
    end

    it "should store (and retrieve) a column type" do
      @with_columns.attribute_column(:title, :string)
      @with_columns.column_for_attribute(:title).type.must_equal :string
    end
  end
end
