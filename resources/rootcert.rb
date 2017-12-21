actions :install, :get

default_action :install if defined?(default_action)

attribute :file_name, name_attribute: true, kind_of: String, required: true, desired_state: true
attribute :url, name_attribute: false, kind_of: String, required: true , desired_state: true
attribute :path, kind_of: String, default: node['sscep']['ca']['certificates_directory'], desired_state: true
attr_accessor :exists # This is a standard ruby accessor, use this to set flags for current state.

load_current_value do |dd| 
  puts "\n"
  puts "c:#{self}"
  puts "\n"
  puts "n:#{dd.url}"
  puts "\n"
  path = dd.path
  self.url = dd.url
  puts "\n"
  puts "self.url:#{self.url}"
  puts "\n"

  file_name = dd.file_name
  current_value_does_not_exist! unless ::File.exist?(::File.join(dd.path, "#{dd.file_name}-0"))
end

action :get do  
  converge_if_changed do
    execute 'Download Root ceritifcate' do
      user 'root'
      group 'root'
      creates ::File.join(new_resource.path, new_resource.file_name)
      command "sscep getca -c #{::File.join(new_resource.path, new_resource.file_name)} -u #{new_resource.url}"
      action :run
    end
  end
end

action :install do  
  converge_if_changed do    
    action_get
    execute 'update-ca-trust' do
      user 'root'
      group 'root'
      command 'update-ca-trust extract'
      action :run
    end    
  end
end

