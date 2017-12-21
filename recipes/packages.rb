%w(openssl wget gcc openssl-devel git).each do |p|
  package p do
    action :upgrade
  end  
end

template "#{Chef::Config['file_cache_path']}/ndes_scep.bash" do
  source "ndes_scep.bash.erb"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
