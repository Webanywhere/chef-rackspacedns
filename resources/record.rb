actions :create

attribute :name,                  :kind_of => String
attribute :value,                 :kind_of => String
attribute :type,                  :kind_of => String
attribute :ttl,                   :kind_of => Integer, :default => 3600
attribute :zone_id,               :kind_of => Integer
attribute :rackspace_username,    :kind_of => String
attribute :rackspace_api_key,     :kind_of => String