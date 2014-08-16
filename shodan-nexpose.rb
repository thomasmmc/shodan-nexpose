require 'nexpose'
require 'yaml'
require_relative 'shodan_api'
require_relative 'nexpose_edit'

#Loading conf variables from YAML file
begin
  config = YAML.load_file("conf.yml")
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

new_ip = call_shodan(shodan_api_key,shodan_search)

if new_ip.any?
  begin
    puts "New ip has been found, going to update Nexpose"
    nexpose_edit_site(instance_name,username,password,nexpose_site,new_ip)
  rescue ArgumentError => e
    puts "Could not update Nexpose: #{e.message}"
  end
else
  puts "No changes found"
end
