actions :create

attribute :domain,                :kind_of => String
attribute :email,                 :kind_of => String
attribute :notes,                 :kind_of => String
attribute :type,                  :kind_of => String,  :default => 'pri_sec'
attribute :ttl,                   :kind_of => Integer, :default => 3600
attribute :rackspace_username,    :kind_of => String
attribute :rackspace_api_key,     :kind_of => String