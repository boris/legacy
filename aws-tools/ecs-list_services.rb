require 'aws-sdk-ecs'
require_relative 'profile'

class Services
    def list
	c = Login.new
	ecs = Aws::ECS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	cluster = ARGV[0]

	services = ecs.list_services({
	    cluster: "#{cluster}",
	    max_results: 100
	})

	services.service_arns.each do |s|
	    puts s
	end
    end

end

Services.new.list

