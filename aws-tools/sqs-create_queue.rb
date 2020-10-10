require 'aws-sdk'
require_relative 'profile'

class Queue

    def create
	c = Login.new
	sqs = Aws::SQS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)
	queue = ARGV[0].downcase

	new_queue = sqs.create_queue(queue_name: queue)
	puts "New queue '#{queue}' created."
	puts "URL: #{queue.queue_url}"
    end

end

Queue.new.create
