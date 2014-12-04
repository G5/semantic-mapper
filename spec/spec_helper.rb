require 'pry'
require 'rspec/its'

module FixturesHelper
  def fixture(fixture_path)
    open(File.join("spec", "fixtures", fixture_path)).read
  end
end

RSpec.configure do |config|
  config.include FixturesHelper
  config.run_all_when_everything_filtered                = true
  config.filter_run :focus

  config.order = 'random'
end

require 'semantic/mapper'
