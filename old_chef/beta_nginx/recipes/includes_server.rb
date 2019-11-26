files = ['location_options.location', 'errors.conf',  'hidden.conf',  'htpassword.conf',  'index.conf',  'limit.conf',  'statics_redirect.conf', 'serve_files.conf.no']

path = File.join(node['nginx']['dir'], 'includes_server')

directory path do
	owner 'root'
	action :create
end

files.each do |file|
	template File.join(path, file) do
	 source file + '.erb'
	end
end
