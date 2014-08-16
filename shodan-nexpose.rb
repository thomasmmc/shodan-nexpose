require 'nexpose'
require 'yaml'
require_relative 'shodan_api'

#Loading conf variables from YAML file
begin
  config = YAML.load_file("conf.yml")
  shodan_api_key = config["shodan_api_key"]
  shodan_search = config["shodan_search"]
  instance_name = config["nexpose_host"]
  instace_port = config["nexpose_port"]
  username = config["nexpose_user"]
  password = config["nexpose_pass"]
  nexpose_site = config[""]
rescue ArgumentError => e
  puts "Could not parse conf YAML: #{e.message}"
end

new_ips = call_shodan(shodan_api_key,shodan_search)

puts new_ips
if new_ips.any?
  puts 'new ips to load into Nexpose'
else
  puts 'same shit'
end
