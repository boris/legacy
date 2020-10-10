require 'aws-sdk'
require_relative 'profile'

class Queue
    def show
	c = Login.new
	sqs = Aws::SQS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)
	queues = sqs.list_queues

	queues.queue_urls.each do |u|
	    puts 'URL: ' + u

	    req = sqs.get_queue_attributes(
		{
		    queue_url: u, attribute_names: [
			'QueueArn',
			'ApproximateNumberOfMessages',
			'ApproximateNumberOfMessagesNotVisible'
		    ]
		}
	    )

	    puts 'ARN: ' + req.attributes['QueueArn']
	    puts 'Messages available: ' + req.attributes['ApproximateNumberOfMessages']
	    puts 'Messages in flight: ' + req.attributes['ApproximateNumberOfMessagesNotVisible']
	    puts ''
	end

    end
end

Queue.new.show
