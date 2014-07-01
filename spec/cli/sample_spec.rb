describe Upackage do

  it "should build package" do
    [
      'mkdir -p debian/',
      "cp -fR #{File.expand_path('../../../templates', __FILE__)}/* debian/*",
      'dpkg-buildpackage -us -us -b'
    ].each do |command|
      expect(SystemGateway.instance).to receive(:perform).with(command)
    end

    creator = Creator.new(SystemGateway.instance)
    creator.create
  end

end
