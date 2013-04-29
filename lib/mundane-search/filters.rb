module MundaneSearch
  module Filters

    # autoload all the stuff in filters under this namespace
    Dir.glob("#{File.dirname(__FILE__)}/filters/*.rb").each do |filename|
      class_name = File.basename(filename, '.*').split('_').collect(&:capitalize).join.to_sym
      autoload class_name, filename
    end

  end
end
