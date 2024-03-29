action :create do
  require "fog"
  require "nokogiri"

  def domain
    @domain ||= new_resource.domain
  end

  def type
    @type ||= new_resource.type
  end

  def ttl
    @ttl ||= new_resource.ttl
  end

  def email
    @email ||= new_resource.email
  end
  
  def dns
   @dns ||= Fog::DNS.new({ :provider => "Rackspace",
                           :rackspace_username => new_resource.rackspace_username,
                           :rackspace_api_key => new_resource.rackspace_api_key }
                         )
  end

  def create
    begin
      dns.zones.create({ :domain => domain,
                         :email => email,
                         :type => type,
                         :ttl => ttl })
    rescue Excon::Errors::BadRequest => e
      Chef::Log.info Nokogiri::XML( e.response.body ).xpath( "//xmlns:Message" ).text
    end
  end

  zone = dns.zones.get(domain)
  
  if zone.nil?
    create
    Chef::Log.info "Zone created: #{domain}"
  else
    Chef::Log.info "Zone already exists, skipping create: #{domain}"
  end
end