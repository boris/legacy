require 'aws-sdk-ecs'
require_relative 'profile'

class Services
    def describe
	c = Login.new
	ecs = Aws::ECS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	cluster = ARGV[0].to_s
	service = ARGV[1]

	service = ecs.describe_services({
	    cluster: cluster,
	    services: [service]
	})

	puts "Service: #{service.services[0].service_name} (#{service.services[0].status})"
	puts "Task Definition: #{service.services[0].task_definition}"
	puts "Workers Count: "
	puts "  Running: #{service.services[0].running_count}"
	puts "  Desired: #{service.services[0].desired_count}"
	puts "  Pending: #{service.services[0].pending_count}"
    end

end

Services.new.describe
