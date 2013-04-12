require 'active_support/concern'
require 'active_model/naming'

module MundaneSearch
  module ActionViewFormComponents
    extend ActiveSupport::Concern

    module ClassMethods
      def model_name
        name = 'GenericSearch' unless self.name
        namespace = nil
        ActiveModel::Name.new(self, namespace, name)
      end
    end

    def to_key
      ['result-of-to-key']
    end
  end
end