require "columns_hash"

require 'mundane-search/railtie' if defined?(Rails)

module MundaneSearch
  autoload :Version, "mundane-search/version"
  autoload :Builder, "mundane-search/builder"
  autoload :FilterCanister, "mundane-search/filter_canister"
  autoload :Result, "mundane-search/result"
  autoload :InitialResult, "mundane-search/initial_result"
  autoload :Filters, "mundane-search/filters"
  autoload :ActionViewFormComponents, "mundane-search/action_view_form_components"
  autoload :Buildable, "mundane-search/buildable"
  autoload :Railtie, "mundane-search/railtie"
  autoload :ViewHelpers, "mundane-search/view_helpers"
end
