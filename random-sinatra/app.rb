require 'sinatra'
require 'pawgen'

get '/' do
    erb :index
end

get '/donate' do
    erb :donate
end

get '/status' do
    status 200
    content_type "text/plain"
    body "This shit won't fail \n"
end

get '/favicon.ico' do
    status 200
    body ""
end

get '/:length' do
    content_type "text/plain"
    l = "#{params['length']}".to_i
    passwd = PawGen.new.set_length!(l).include_uppercase!.include_digits!.include_symbols!.exclude_ambiguous!
    "#{passwd.anglophonemic} \n"
end

get '/:length/:count' do |length, count|
    content_type "text/plain"
    l = "#{length}".to_i
    c = "#{count}".to_i
    passwd = PawGen.new.set_length!(l).include_uppercase!.include_digits!.include_symbols!.exclude_ambiguous!
    result = []
    c.times do
	result.push(passwd.anglophonemic)
    end
    "#{result.join("\n")} \n"
end
