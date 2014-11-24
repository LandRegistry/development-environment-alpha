require 'rspec'
require 'open3'
require 'curb'


def serviceRunningOnPort(service)
  serviceHash = service.split(":")
  validPort = false
  begin
    c = Curl::Easy.http_get( "HTTP://0.0.0.0:"+ serviceHash[1])
    puts serviceHash[0] + " is responding successfully to HTTP requests on port " + serviceHash[1]
    validPort = true
  rescue
    puts serviceHash[0] + " is NOT responding to successfully HTTP requests on port " + serviceHash[1]
  end
  return validPort
  puts "=========================="
end

def serviceRunningInNetstat(service)
  serviceHash = service.split(":")
  validPort = false
  exit_code = system('netstat -an | grep ":' + serviceHash[1] + ' " | grep LISTEN > /dev/null 2>&1')
  if exit_code != false then
    puts serviceHash[0] + " is running on port " + serviceHash[1]
    validPort = true
  else
    puts serviceHash[0] + " NOT RUNNING ON PORT " + serviceHash[1]
  end
  return validPort
end


describe "Environment" do
    it "Check system-of-record service is running on intended ports and in netstat" do
      #expect(serviceRunningOnPort()).to be(true)
      expect(serviceRunningOnPort('system-of-record:8000')).to be(true)
      expect(serviceRunningInNetstat('system-of-record:8000')).to be(true)
    end

    it "Check mint service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('mint:8001')).to be(true)
      expect(serviceRunningInNetstat('mint:8001')).to be(true)
    end

    it "Check property-frontend service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('property-frontend:8002')).to be(true)
      expect(serviceRunningInNetstat('property-frontend:8002')).to be(true)
    end

    it "Check search-api service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('search-api:8003')).to be(true)
      expect(serviceRunningInNetstat('search-api:8003')).to be(true)
    end

    it "Check casework-frontend service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('casework-frontend:8004')).to be(true)
      expect(serviceRunningInNetstat('casework-frontend:8004')).to be(true)
    end

      # expect(serviceRunningOnPort('generate-test-data:0')).to be(true)

    it "Check the-feeder service is running on intended ports and in netstat" do
      #expect(serviceRunningOnPort('the-feeder:6379')).to be(true)
      expect(serviceRunningInNetstat('the-feeder:6379')).to be(true)
    end

    it "Check service-frontend service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('service-frontend:8007')).to be(true)
      expect(serviceRunningInNetstat('service-frontend:8007')).to be(true)
    end

    it "Check decision service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('decision:8009')).to be(true)
      expect(serviceRunningInNetstat('decision:8009')).to be(true)
    end

      #expect(serviceRunningOnPort('acceptance-tests:0')).to be(true)
      # expect(serviceRunningOnPort('datatypes:0')).to be(true)
      # expect(serviceRunningOnPort('audit-plugin:0')).to be(true)

    it "Check html-prototypes service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('html-prototypes:9000')).to be(true)
      expect(serviceRunningInNetstat('html-prototypes:9000')).to be(true)
    end

      # expect(serviceRunningOnPort('secrets:0')).to be(true)

    it "Check style-guide service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('style-guide:9001')).to be(true)
      expect(serviceRunningInNetstat('style-guide:9001')).to be(true)
    end

      # expect(serviceRunningOnPort('service-tests:0')).to be(true)

    it "Check ownership service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('ownership:8010')).to be(true)
      expect(serviceRunningInNetstat('ownership:8010')).to be(true)
    end

    it "Check matching service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('matching:8011')).to be(true)
      expect(serviceRunningInNetstat('matching:8011')).to be(true)
    end

    it "Check fixtures service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('fixtures:8012')).to be(true)
      expect(serviceRunningInNetstat('fixtures:8012')).to be(true)
    end

    it "Check introductions service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('introductions:8813')).to be(true)
      expect(serviceRunningInNetstat('introductions:8813')).to be(true)
    end

    it "Check cases service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('cases:8014')).to be(true)
      expect(serviceRunningInNetstat('cases:8014')).to be(true)
    end

    it "Check historian service is running on intended ports and in netstat" do
      expect(serviceRunningOnPort('historian:8015')).to be(true)
      expect(serviceRunningInNetstat('historian:8015')).to be(true)
    end

      # expect(serviceRunningOnPort('lr-utils:0')).to be(true)
end
