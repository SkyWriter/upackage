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
      fill_templates
      system.perform('dpkg-buildpackage -us -us -b')
    end

    attr_reader :system, :fs

    private

    def fill_templates
      %w(changelog compat control dirs docs files install postinst postrm prerm rules).each do |filename|
        fs.put_file("debian/#{filename}", ERB.new(IO.read(template_path(filename))).result(binding))
      end
    end

    def template_path(filename)
      File.expand_path("../../templates/#{filename}.erb", __FILE__)
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
