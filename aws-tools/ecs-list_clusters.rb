require 'aws-sdk'
require_relative 'profile'

class Cluster
    def list
	c = Login.new
	ecs = Aws::ECS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	clusters = ecs.list_clusters({})

	clusters.cluster_arns.each do |c|
	    puts c
	end

    end
end

Cluster.new.list
