require 'aws-sdk-ecs'
require_relative 'profile'

class Service
    def create
	c = Login.new
	ecs = Aws::ECS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	cluster = ARGV[0].to_s
	service = ARGV[1]
	taskdef = ARGV[2]
	workers = ARGV[3].to_i

	service = ecs.create_service({
	    cluster: "#{cluster}",
	    desired_count: workers,
	    service_name: "#{service}",
	    task_definition: "#{taskdef}",
	    deployment_configuration: {
		minimum_healthy_percent: 50,
		maximum_percent: 200
	    }
	})

	puts "Service #{service.service.service_name} launched on #{cluster} using EC2 deployment."
	puts "Task Definition: #{service.service.task_definition}"
    end
end

Service.new.create
