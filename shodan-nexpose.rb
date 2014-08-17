require 'nexpose'
require 'yaml'
require_relative 'shodan_api'
require_relative 'nexpose_edit'

v1 = ARGV[0]
if v1.nil?
  conf_file = "conf.yml"
else
  conf_file = v1
end

#Loading conf variables from YAML file
begin
  config = YAML.load_file(conf_file)
  shodan_api_key = config["shodan_api_key"]
  shodan_search = config["shodan_search"]
  instance_name = config["nexpose_host"]
  instace_port = config["nexpose_port"]
  username = config["nexpose_user"]
  password = config["nexpose_pass"]
  nexpose_site = config["nexpose_site"]
rescue ArgumentError => e
  puts "Could not parse conf YAML: #{e.message}"
end

#Running the method call_shodan which used the shodan gem to run our query
new_ip = call_shodan(shodan_api_key,shodan_search)

if new_ip.any?
  begin
    puts "New ip has been found, going to update Nexpose"
    #Running the method which uses the nexpose gem to update our specified site
    nexpose_edit_site(instance_name,username,password,nexpose_site,new_ip)
  rescue ArgumentError => e
    puts "Could not update Nexpose: #{e.message}"
  end
else
  puts "No changes found"
end
