
# web.rb
require 'sinatra'
require 'json'
require './data_center.rb'

# vm list
#
# vm create
#
# vm delete
#
# ssh key post

# ssh key delete
get '/instance/' do
  dc = DataCenter.new(1)
  data = dc.get_all

  data.to_json
end

post '/instance' do
  dc = DataCenter.new(1)
  data = dc.create_instance(1, 1, 1)

  data.to_json
end
