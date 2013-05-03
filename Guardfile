# More info at https://github.com/guard/guard#readme
# guard 'minitest', :seed => "23242" do
guard 'minitest' do
  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb".sub("spec/mundane-search/", "spec/") }
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) do |m|
    "spec/#{m[1]}#{m[2]}_integration_spec.rb".sub("spec/mundane-search/", "spec/")
  end
  watch(%r|^spec/spec_helper\.rb|)   { "spec" }
  watch("spec/minitest_helper.rb")   { "spec" }
end
