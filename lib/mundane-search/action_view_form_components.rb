require 'active_support/concern'

module MundaneSearch
  module ActionViewFormComponents
    extend ActiveSupport::Concern

    included do
      extend ActiveModel::Naming
    end

    def to_key
      ['result-of-to-key']
    end
  end
end