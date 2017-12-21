working_dir = "#{Chef::Config[:file_cache_path]}/sscep"
git working_dir do
  repository node['sscep']['repo']
  action :sync
end

execute '[sscep] configure' do
  cwd working_dir
  creates "#{working_dir}/Makefile"
  command 'bash ./Configure'
  action :run
end

execute '[sscep] make' do
  cwd working_dir
  creates "#{working_dir}/sscep"
  command 'make'
  action :run
end

execute '[sscep] install' do
  cwd working_dir
  creates '/usr/local/bin/sscep'
  command 'make install'
  action :run
end
