require 'aws-sdk-s3'
require_relative 'profile'

class Bucket
    def create
	c = Login.new

	bucket = ARGV[0]

	s3 = Aws::S3::Resource.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	s3.create_bucket(bucket: "#{bucket}")
    end
end

Bucket.new.create
