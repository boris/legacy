require 'aws-sdk'
require_relative 'profile'

class Repository
    def create
	c = Login.new
	repo = ARGV[0].downcase
    end
end
