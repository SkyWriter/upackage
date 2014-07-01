describe Upackage do

  it "should build package" do
    expect(commands).to be == [
      'git clone git@red:sample-project.git',
      'dpkg-buildpackage -b -us'
    ]
  end

end
