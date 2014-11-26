
require_relative 'lib/functions.rb'




describe "Environment" do

  it "Postgres tables" do
    expect(postgresTable('service_frontend')).to be(true)
    expect(postgresRoleExist('postgres')).to be(true)
  end

  it "nginx installed" do
    expect(serviceInstalled('nginx')).to be(true)
    expect(serviceRunning('nginx')).to be(true)
  end

  it "Elastic Search installed" do
    expect(serviceInstalled('elasticsearch')).to be(true)
    expect(serviceRunning('elasticsearch')).to be(true)
  end

  it "PostgreSQL installed" do
    expect(serviceInstalled('postgresql')).to be(true)
    expect(serviceRunning('postgresql')).to be(true)
  end

end
