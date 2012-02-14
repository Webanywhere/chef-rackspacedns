Description
===========

Provides LWRPs that allow interaction with the Rackspace DNS service from your chef recipes.

Requirements
============

A Rackspace account.

Usage
=====

```ruby
include_recipe "rackspacedns"

rackspacedns_zone "create a zone" do
  domain  "test.com"
  email   "hostmaster@test.com"

  rackspace_username          "username"
  rackspace_api_key          "long_string"

  action :create
end

rackspacedns_record "create a record" do
  name  "test"
  value "16.8.4.2"
  type  "A"
  ttl 3600

  zone_id               33016
  rackspace_username          "username"
  rackspace_api_key          "long_string"

  action :create
end
```

Credits
=======

Inspired by http://community.opscode.com/cookbooks/zerigo/.

Known Issues
============

The Zone ID has to be an actual ID and not a zone name. This is an issue with the Rackspace API and should be relatively easy to work around at some point