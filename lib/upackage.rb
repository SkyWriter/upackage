require "upackage/version"
require "singleton"

module Upackage

  class Creator
    def initialize(system)
      @system = system
    end

    def create
      system.perform('mkdir -p debian/')
      system.perform("cp -fr #{templates_path}/* debian/")
      system.perform('dpkg-buildpackage -us -us -b')
    end

    attr_reader :system

    private

    def templates_path
      File.expand_path('../../templates', __FILE__)
    end
  end

  class SystemGateway
    include Singleton

    def perform(command)
      puts "Performing: #{command}"
      system(command)
    end
  end

end
