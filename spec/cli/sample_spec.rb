describe Upackage do

  it "should build package" do
    [
      'git clone git@red:sample-project.git',
      'mkdir -p debian/',
      'cp -fR templates/* debian/*',
      'dpkg-buildpackage -us -us -b'
    ].each do |command|
      expect(SystemGateway.instance).to receive(:perform).with(command)
    end

    creator = Creator.new(SystemGateway.instance)
    creator.create
  end

end
