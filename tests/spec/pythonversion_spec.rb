require_relative 'lib/functions.rb'


describe "Environment" do
  it "Python Version" do
    expect(pythonVersion()).to eq('2.7.6')
  end
end
