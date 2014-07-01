describe Upackage do

  it "should build package" do
    [
      'mkdir -p debian/',
      'dpkg-buildpackage -us -us -b'
    ].each do |command|
      expect(SystemGateway.instance).to receive(:perform).with(command)
    end

    %w(changelog compat control dirs docs files postinst postrm prerm rules).each do |filename|
      contents = IO.read(File.expand_path("../../fixtures/#{filename}", __FILE__))
      expect(FSGateway.instance).to receive(:put_file).with(filename, contents)
    end

    creator = Creator.new(SystemGateway.instance, FSGateway.instance)
    creator.create
  end

end
