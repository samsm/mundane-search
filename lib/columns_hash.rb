require 'ostruct'

module ColumnsHash
  class Attribute < OpenStruct
    def number?
      number
    end
  end

  def self.generate(options)
    type = options[:type]
    attribute = Attribute.new(options)
    case type
    when :string
      attribute.limit = 255
    when :integer, :float
      attribute.number =  true
    end
    attribute
  end

  def column_for_attribute(attribute)
    columns_hash[attribute]
  end

  def attribute_column(name, attribute_type)
    columns_hash[name] = ColumnsHash.generate({name: name, type: attribute_type})
  end

  def columns_hash
    @columns_hash ||= {}
  end
end