module MundaneSearch
  class Railtie < Rails::Railtie
    initializer "mundane-search.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end