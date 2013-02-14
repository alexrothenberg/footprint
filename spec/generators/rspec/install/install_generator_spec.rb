require "spec_helper"
require 'generators/footprint/install/install_generator'

describe Footprint::Generators::InstallGenerator do
  destination File.expand_path("../../../../../tmp/sample", __FILE__)
  before do
    prepare_destination

    example_app = File.expand_path("../../../../../tmp/example_app", __FILE__)
    %w(script).each do |dir|
      `ln -s #{example_app + '/' + dir} #{destination_root}`
    end
    `mkdir #{destination_root}/config`
    Dir["#{example_app}/config/*"].each do |dir|
      `ln -s #{dir} #{destination_root}/config`
    end
  end

  describe "generates mongoid configuration" do
    before { run_generator }
    subject { file('config/mongoid.yml') }
    it { should exist }
  end
end
