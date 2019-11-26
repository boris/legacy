default[:beta_nginx][:upstreams] = []

#Ej: {name: 'name', port: '8000', hosts: ['ip1', 'ip2']}
#produces:
# upstream name {
#    server ip1:8000;
#    server ip2:8000;
# }

default[:beta_nginx][:location_options] = {} 
