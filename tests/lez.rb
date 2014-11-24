require 'rspec'
require 'open3'
require 'curb'


def serviceRunningOnPort()

  # stdin, stdout, wait_thr = Open3.popen2("service --status-all")
  # result = stdout.read
  #
  # puts result
  #
  # services = result.scan(/\[ [\-|\+|\?] \]  (.*)\n/)
  #
  # found = false
  # services.each do |item|
  #   if (item[0] == servicename) then
  #     found = true
  #   end
  # end
  # return found

  # contents = File.read('../config/apps')

  File.open("../config/apps", "r") do |file_handle|
    file_handle.each_line do |fileLine|
      # do stuff to server here

      fileLine = fileLine.strip

      if !fileLine.empty? and !fileLine.include? "#" then
        entryHash = fileLine.split(":")
        if entryHash[1] != "0" then
          validPort = false
          begin
            c = Curl::Easy.http_get( "HTTP://0.0.0.0:"+ entryHash[1])
            puts c.response_code
            puts entryHash[0] + " is responding successfully to HTTP requests on port " + entryHash[1]
            validPort = true
          rescue
            puts entryHash[0] + " is NOT responding to successfully HTTP requests on port " + entryHash[1]
          end
          expect(validPort).to be(true)
          puts validPort
        end

      end
    end
  end


  puts "=========================="


  File.open("../config/apps", "r") do |file_handle|
    file_handle.each_line do |fileLine|
      # do stuff to server here

      fileLine = fileLine.strip

      if !fileLine.empty? and !fileLine.include? "#" then
        entryHash = fileLine.split(":")
        if entryHash[1] != "0" then
          validPort = false
          exit_code = system('netstat -an | grep ":' + entryHash[1] + ' " | grep LISTEN > /dev/null 2>&1')
          puts exit_code
          if exit_code != false then
            puts entryHash[0] + " is running on port " + entryHash[1]
            validPort = true
          else
            puts entryHash[0] + " NOT RUNNING ON PORT " + entryHash[1]
          end
          expect(validPort).to be(true)
          puts validPort
        end
      end
    end
  end


 return true


end


describe "Environment" do

    it "Check all services are running on intended ports" do
      expect(serviceRunningOnPort()).to be(true)
    end

end
