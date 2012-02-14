action :create do
  require "fog"
  require "nokogiri"

  def name
    @name ||= new_resource.name
  end

  def value
    @value ||= new_resource.value
  end

  def type
    @type ||= new_resource.type
  end

  def ttl
    @ttl ||= new_resource.ttl
  end

  def zone
    @zone ||= Fog::DNS.new({ :provider => "Rackspace",
                             :rackspace_username => new_resource.rackspace_username,
                             :rackspace_api_key => new_resource.rackspace_api_key }
                           ).zones.get( new_resource.zone_id )
  end

  def create
    begin
      zone.records.create({ :name => name,
                            :value => value,
                            :type => type,
                            :ttl => ttl })
    rescue Excon::Errors::BadRequest => e
      Chef::Log.info Nokogiri::XML( e.response.body ).xpath( "//xmlns:Message" ).text
    end
  end

  record = zone.records.all.select do |record|
    record.name == name
  end.first

  if record.nil?
    create
    Chef::Log.info "Record created: #{name}"
  elsif value != record.value
    record.destroy
    create
    Chef::Log.info "Record modified: #{name}"
  end
end