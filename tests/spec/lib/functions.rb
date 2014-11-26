require 'open3'


def serviceInstalled(servicename)

  stdin, stdout, stderr = Open3.popen3("service --status-all")
  result = stdout.read + stderr.read
  services = result.scan(/\[ [\-|\+|\?] \]  (.*)\n/)

  found = false
  services.each do |item|
    if (item[0] == servicename) then
      found = true
    end
  end
  return found
end

def serviceRunning(servicename)

  stdin, stdout, stderr = Open3.popen3("service --status-all")
  result = stdout.read
  services = result.scan(/\[ (.*) \]  (.*)\n/)

  found = false
  services.each do |item|
    if ((item[0] == '+') && (item[1] == servicename)) then
      found = true
    end
  end
  return found
end

def postgresTable(tablename)

  stdin, stdout, stderr = Open3.popen3('sudo su postgres -c "psql -c \'SELECT datname FROM pg_database\'"')
  result = stdout.read

  tables = result.split(/\n/i)

  found = false

  tables.each do |item|
    if (item.strip == tablename) then
      found = true
    end
  end

  return found

end

def postgresRoleExist(rolename)

  stdin, stdout, stderr = Open3.popen3('sudo su postgres -c "psql -c \'SELECT rolname FROM pg_roles\'"')
  result = stdout.read

  tables = result.split(/\n/i)

  found = false

  tables.each do |item|
    if (item.strip == rolename) then
      found = true
    end
  end

  return found

end
