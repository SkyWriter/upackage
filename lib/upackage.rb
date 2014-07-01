require "upackage/version"
require "singleton"

module Upackage

  class Creator
    def initialize(system, fs)
      @system = system
      @fs = fs
    end

    def create
      system.perform('mkdir -p debian/')
      system.perform('dpkg-buildpackage -us -us -b')
    end

    attr_reader :system

    private

    def fill_templates
      %w(changelog compat control dirs docs files install postinst postrm prerm rules)
    end

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

  class FSGateway
    include Singleton

    def put_file(filename, contents)
      File.new(filename, "w") do |file|
        file.write(contents)
        file.close
      end
    end
  end

end
