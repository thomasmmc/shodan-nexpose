require 'nexpose'

def nexpose_edit_site(instance,username,password,site_id,newip)
  begin
    #connecting to nexpose instance
    nsc = Nexpose::Connection.new(instance, username, password)
    nsc.login
    #loading the site we want to edit
    site = Nexpose::Site.load(nsc, site_id)
    #adding each new ip to the site
    newip.each do |ip|
      site.add_ip(ip)
    end
    #Saving the changes to the site
    site.save(nsc)
  rescue Exception => e
        return "Nexpose API Error: #{e.to_s}"
  end
end
