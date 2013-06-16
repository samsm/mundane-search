require "columns_hash"

require 'mundane-search/railtie' if defined?(Rails)

module MundaneSearch
  autoload :Version, "mundane-search/version"
  autoload :Builder, "mundane-search/builder"
  autoload :FilterCanister, "mundane-search/filter_canister"
  autoload :Stack, "mundane-search/stack"
  autoload :Result, "mundane-search/result"
  autoload :ResultModel, "mundane-search/result_model"
  autoload :InitialStack, "mundane-search/initial_stack"
  autoload :Filters, "mundane-search/filters"
  autoload :Buildable, "mundane-search/buildable"
  autoload :Railtie, "mundane-search/railtie"
  autoload :ViewHelpers, "mundane-search/view_helpers"
  autoload :ParamKeyTypes, "mundane-search/param_key_types"
end
