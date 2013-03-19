require "bundler/gem_tasks"

require 'rake/testtask'

namespace 'test' do
  test_files             = FileList['spec/**/*_spec.rb']
  integration_test_files = FileList['spec/**/*_integration_spec.rb']
  unit_test_files        = test_files - integration_test_files

  desc "Run unit tests"
  Rake::TestTask.new('unit') do |t|
    t.libs.push "lib"
    t.test_files = unit_test_files
    t.verbose = false
  end

  desc "Run integration tests"
  Rake::TestTask.new('integration') do |t|
    t.libs.push "lib"
    t.test_files = integration_test_files
    t.verbose = false
  end
end

namespace 'database' do
  desc "Setup test database"
  task :test_setup do
    require './spec/active_record_setup'
    ActiveRecord::Migration.create_table :books do |t|
      t.string    :title
      t.string    :author
      t.date      :publication_date
      t.timestamp :first_purchased_at
      t.integer   :sold
    end
  end
end

#Rake::Task['test'].clear
desc "Run all tests"
task 'test' => %w[test:unit test:integration]
task 'default' => 'test'
