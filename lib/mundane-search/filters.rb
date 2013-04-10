module MundaneSearch
  module Filters
    filters_path = "#{File.dirname(__FILE__)}/filters"

    autoload :Helpers,           "#{filters_path}/helpers"
    autoload :Base,              "#{filters_path}/base"
    autoload :Typical,           "#{filters_path}/typical"
    autoload :ExactMatch,        "#{filters_path}/exact_match"
    autoload :BlankParamsAreNil, "#{filters_path}/blank_params_are_nil"
    autoload :AttributeMatch,    "#{filters_path}/attribute_match"
    autoload :Operator,          "#{filters_path}/operator"
  end
end
