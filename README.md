# Shodan Nexpose
This is some simple code uses the Nexpose and Shodan GEMs to update a Nexpose site.

# What is Shodan?
[Shodan](http://www.shodanhq.com) is a couple of things, but basically it is a search engine for Internet-connected devices.
In this use case we are using Shodan as one of the ways we track of all the computers on our network that are directly accessible from the Internet.

The Shodan API is a great tool for security groups to get a programatic look at there external footprint if there is no other external monitoring in place, or as we do, just as another source for this information.
You will need to have a Shodan account, and for this to work optimally, you should also have the full API add-on, which is a small fee.
[Shodans Developer site](https://developer.shodan.io/)

# What is Nexpose?
[Nexpose](https://www.rapid7.com/products/nexpose/) is a vulnerability management platform written and sold by Rapid7.
Nexpose has the ability to run distributed scan engines to assess your systems from multiple points.  These scan engines can be hosted by an organization, or can be subscribed to from Rapid7.

In this case, we are updating an Nexpose site which is associated with an external scan engine so that we are scanning all external resources and not missing anything.
[Nexpose API site](https://community.rapid7.com/community/nexpose/nexpose-apis)

# Usage

## gems
``` ruby
require 'shodan'
require 'nexpose'
require 'yaml'
```

## Config file
```yaml
shodan_api_key: 123456789
shodan_search: org:"Rapid7 LLC"
nexpose_host: nexpose.domain.tld
nexpose_port: 3780
nexpose_user: nxadmin
nexpose_pass: nxadmin
nexpose_site: pubic_webservers
```
