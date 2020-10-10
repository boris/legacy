require 'aws-sdk-ecs'
require_relative 'profile'

class Service
    def update
	c = Login.new
	ecs = Aws::ECS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	cluster = ARGV[0]
	service = ARGV[1]
	count = ARGV[2]

	update = ecs.update_service({
	    cluster: "#{cluster}",
	    service: "#{service}",
	    desired_count: count
	})

	puts "Service: #{update.service.service_name}" 
	puts "Status: #{update.service.status}"
	puts "Workers Count: "
	puts "  Running: #{update.service.running_count}"
	puts "  Desired: #{update.service.desired_count}"
	puts "  Pending: #{update.service.pending_count}"
    end
end

Service.new.update
