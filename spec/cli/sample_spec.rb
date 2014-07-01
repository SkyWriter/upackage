require 'singleton'

class Creator
  def initialize(system)
    @system = system
  end

  def create
    system.perform('git clone git@red:sample-project.git')
    system.perform('dpkg-buildpackage -us -us -b')
  end

  attr_reader :system
end

class SystemGateway
  include Singleton

  def perform(command)
    system(command)
  end
end

describe Upackage do

  it "should build package" do
    [
      'git clone git@red:sample-project.git',
      'dpkg-buildpackage -us -us -b'
    ].each do |command|
      expect(SystemGateway.instance).to receive(:perform).with(command)
    end

    creator = Creator.new(SystemGateway.instance)
    creator.create
  end

end
