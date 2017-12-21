use_inline_resources

def do_install
  execute 'update-ca-trust' do
    user 'root'
    group 'root'
    command 'update-ca-trust extract'
    action :run
  end  
end

def do_get
    execute 'Download Root ceritifcate' do
      user 'root'
      group 'root'
      creates ::File.join(new_resource.path, new_resource.file_name)
      command "sscep getca -c #{::File.join(new_resource.path, new_resource.file_name)} -u #{new_resource.url}"
      action :run
    end
end
