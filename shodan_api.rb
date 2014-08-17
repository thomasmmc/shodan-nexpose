require 'shodan'
require 'yaml'

def call_shodan(shodan_api_key,shodan_search)
  #Loading colletion from previous run
  begin
  ip_collection = Array.new
  if File.file?("shodan_collection.yml")
    then
      ip_collection = YAML.load_file('shodan_collection.yml')
    else
      f = File.new("shodan_collection.yml", "w")
      f.close
    end
  rescue ArgumentError => e
    return "Could not parse collection YAML: #{e.message}"
  end

  #Checking to make sure the API key and search is set
  if shodan_api_key.nil? && shodan_search.nil?
    then return "Error: no API key or search found, will not connect to Shodan"
  else
    begin
      #Call the shodan gem and run our search
      api = Shodan::Shodan.new(shodan_api_key)
      #Run the search against shodan
      result = api.search(shodan_search)
      #loads the results into a new Array
      resip = Array.new
      result['matches'].each do |host|
         resip.push(host['ip_str'])
        end
      #check to see if the result count is > 100, we will need to do paging
        pages = (result['total']/100.0).ceil
        if pages > 1 then
          page = 2
          while pages >= page do
            result = api.search(shodan_search, :page => page)
            result['matches'].each do |host|
               resip.push(host['ip_str'])
              end
            page = page+1
          end
        else
        end

    rescue Exception => e
        return "Shodan API Error: #{e.to_s}"
    end
  end

  #writing a collection for use in the next running of this
puts resip.uniq.count
  results_file = resip.uniq.to_yaml
  File.open("shodan_collection.yml", 'w') {|f| f.write results_file }

  #comparing the arrays and determaning which to return
  diff_ip = Array.new
  resip.each do |ip|
    if ip_collection.include?(ip)
    else
      diff_ip << ip
    end
  end
  diff_ip
end
