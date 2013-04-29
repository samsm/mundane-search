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
    let(:columned_class) do
      Class.new do
        include ColumnsHash
      end
    end
    let(:columned) { columned_class.new }

    it "should have a columns_hash" do
      columned_class.columns_hash.must_be_kind_of Hash
    end

    it "should store (and retrieve) a column type" do
      columned_class.attribute_column(:title, :string)
      columned.column_for_attribute(:title).type.must_equal :string
    end
  end
end
