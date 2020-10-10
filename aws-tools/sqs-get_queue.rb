require 'aws-sdk-sqs'
require_relative 'profile'

class Queue
    def describe
	c = Login.new
	sqs = Aws::SQS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	queue = ARGV[0]

	queue_url = sqs.get_queue_url({
	    queue_name: "#{queue}"
	}) 
	
	url = queue_url.queue_url

	req = sqs.get_queue_attributes({
	    queue_url: "#{url}",
	    attribute_names: ["Policy"]
	})

	puts req.attributes
    end
end

Queue.new.describe
