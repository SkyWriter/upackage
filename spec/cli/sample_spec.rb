describe Upackage do

  let(:repository) { 'git@red:sample-project.git' }

  it "should build package" do
    [
      "git clone #{repository}",
      'mkdir -p debian/',
      "cp -fR #{File.expand_path('../../../templates', __FILE__)}/* debian/*",
      'dpkg-buildpackage -us -us -b'
    ].each do |command|
      expect(SystemGateway.instance).to receive(:perform).with(command)
    end

    creator = Creator.new(SystemGateway.instance, repository)
    creator.create
  end

end
