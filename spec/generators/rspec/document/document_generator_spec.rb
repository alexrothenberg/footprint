require "spec_helper"

# Generators are not automatically loaded by Rails
require 'generators/footprint/document/document_generator'

describe Footprint::Generators::DocumentGenerator do
  destination File.expand_path("../../../../../tmp/sample", __FILE__)

  before do
    prepare_destination

    example_app = File.expand_path("../../../../../tmp/example_app", __FILE__)
    %w(config script).each do |dir|
      `ln -s #{example_app + '/' + dir} #{destination_root}`
    end
    `mkdir -p #{destination_root}/app/models`
  end

  describe "with valid ActiveRecord model" do
    describe "generates a document" do
      before { run_generator %w(Yeti) }
      subject { file('app/models/yeti_footprint.rb') }
      it { should exist }
      it { should contain 'class YetiFootprint < Footprint::Impression'}
    end
  end
end
