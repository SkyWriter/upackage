class StubFSGateway
  attr_reader :files

  def initialize
    @files = { }
  end

  def put_file(file, contents)
    @files[file] = contents
  end
end

describe Upackage do

  it "should build package" do
    [
      'mkdir -p debian/',
      'dpkg-buildpackage -us -us -b'
    ].each do |command|
      expect(SystemGateway.instance).to receive(:perform).with(command)
    end

    stub_fs_gateway = StubFSGateway.new
    creator = Creator.new(SystemGateway.instance, stub_fs_gateway)
    creator.create

    %w(changelog compat control dirs docs files postinst postrm prerm rules).each do |filename|
      needed_content = IO.read(File.expand_path("../../fixtures/#{filename}", __FILE__))
      expect(stub_fs_gateway.files["debian/#{filename}"]).to eq needed_content
    end

  end

end
