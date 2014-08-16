require 'nexpose'

def nexpose_edit_site(instance,username,password,site_id,newip)
  nsc = Nexpose::Connection.new(instance, username, password)
  nsc.login
  puts 'Logged into Nexpose'

  puts "Editing site #{site_id}"
  site = Nexpose::Site.load(nsc, site_id)
  newip.each do |ip|
    site.add_ip(ip)
  end
    site.save(nsc)
  puts 'Edited site successfully'
end
