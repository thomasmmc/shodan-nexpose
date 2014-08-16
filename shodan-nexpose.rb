require 'shodan'
require 'nexpose'
require 'yaml'

#Loading conf variables from YAML file
config = YAML.load_file("conf.yml")
shodan_api_key = config["shodan_api_key"]
shodan_search = config["shodan_search"]
instance_name = config["nexpose_host"]
instace_port = config["nexpose_port"]
username = config["nexpose_user"]
password = config["nexpose_pass"]

#Call the shodan gem and run our search
api = Shodan::Shodan.new(shodan_api_key)

begin
  result = api.search(shodan_search)
  resultcount = result['total']
  puts resultcount
  result['matches'].each do |host|
      puts host['ip_str']
    end
rescue Exception => e
    puts "Error: #{e.to_s}"
else
    puts "Unknown error"
end
