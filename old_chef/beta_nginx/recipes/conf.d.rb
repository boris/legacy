files = ['options.conf', 'proxy_options.conf', 'log_format.conf', 'www_redirect.conf', 'upstreams.conf']

path = File.join(node['nginx']['dir'], 'conf.d')

directory path do
	owner 'root'
	action :create
end

files.each do |file|
	template File.join(path, file) do
	 source file + '.erb'
	end
end