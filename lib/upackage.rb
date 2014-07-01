require "upackage/version"
require "singleton"

module Upackage

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
      puts "Performing: #{command}"
      system(command)
    end
  end

end
