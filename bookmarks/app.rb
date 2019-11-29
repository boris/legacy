#!/usr/bin/env ruby
require "thor"
require "json"
require "mongo"
require 'terminal-table'
require "colored"

class MyLinks < Thor

    desc "add", "this is add a new link"
    def add
	printf "URL: "
	url = STDIN.gets.chomp
	printf "Name: "
	name = STDIN.gets.chomp

	Mongo::Logger.logger.level = Logger::WARN
	client = Mongo::Client.new('mongodb://127.0.0.1:32769/test')
	collection = client[:links]
	doc = {url: "#{url}", name: "#{name}"}
	collection.insert_one(doc)
	puts "Item saved!" + " ✓ ".bold.green

    end

    desc "show", "show links"
    def show
	Mongo::Logger.logger.level = Logger::WARN
	client = Mongo::Client.new('mongodb://127.0.0.1:32769/test')
	collection = client[:links]
	n = 0
	rows = []
	collection.find.each do |doc|
	    rows << ["#{n}", "#{doc['name']}", "#{doc['url']}"]
	    n = n+1
	end
	table = Terminal::Table.new :headings => ['ID'.bold.cyan, 'Name'.bold.cyan, 'URL'.bold.cyan], :rows => rows
	puts table
    end
end

MyLinks.start(ARGV)
