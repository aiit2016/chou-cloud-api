
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

# curl localhost:4567/instance/?token=1
get '/instance/' do
  user_id = params[:token]
  dc = DataCenter.new(user_id)
  data = dc.get_all

  data.to_json
end

# curl localhost:4567/instance/ -X POST -d '{"cpu": 1, "memory": 2, "token": 3}'
post '/instance/' do
  param = JSON.parse(request.body.read)
  user_id = param['token']
  memory = param['memory']
  cpu = param['cpu']
  ssh_id = params[:ssh_id]
  dc = DataCenter.new(user_id)
  data = dc.create_instance(memory, cpu, ssh_id)

  data.to_json
end
