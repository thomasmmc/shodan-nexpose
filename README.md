# Shodan Nexpose
This is some simple code uses the Nexpose and Shodan GEMs to update a Nexpose site.

## GEMS
``` ruby
require 'shodan'
require 'nexpose'
require 'yaml'
```

## Config file
``` yaml
shodan_api_key: 123456789
shodan_search: org:"Rapid7 LLC"
nexpose_host: nexpose.domain.tld
nexpose_port: 3780
nexpose_user: nxadmin
nexpose_pass: nxadmin
```
