
# web.rb
require 'sinatra'
require 'json'
require './data_center.rb'

before do
  content_type 'application/json'
end

# vm list
#
# vm create
#
# vm delete
#
# ssh key post

# ssh key delete

# curl localhost:4567/instance?token=1
get '/instances' do
  user_id = params[:token]
  dc = DataCenter.new(user_id)
  data = dc.get_all

  data.to_json
end

get '/instances/:id' do
  user_id = params[:token]
  dc = DataCenter.new(user_id)
  data = dc.get_all

  data.to_json
end

# curl localhost:4567/instance -X POST -d '{"cpu": 1, "memory": 2, "token": 3}'
post '/instances' do
  param = JSON.parse(request.body.read)
  name = param['name']
  user_id = param['token']
  memory = param['memory']
  cpu = param['cpu']
  ssh_id = params[:ssh_id]
  dc = DataCenter.new(user_id)
  data = dc.create_instance(name, memory, cpu, ssh_id)

  data.to_json
end

put '/instances/:id' do
  param = JSON.parse(request.body.read)
  instance_id = params[:id]
  name = param['name']
  user_id = param['token']
  memory = param['memory']
  cpu = param['cpu']
  ssh_id = params[:ssh_id]
  dc = DataCenter.new(user_id)
  data = dc.update_instance(instance_id, name: name, memory: memory, cpu: cpu, ssh_id: ssh_id)

  data.to_json
end

post '/instances/:id/up' do
  instance_id = params[:id]
  data = dc.start_instance(instance_id)

  data.to_json
end

post '/instances/:id/down' do
  instance_id = params[:id]
  data = dc.sop_instance(instance_id)

  data.to_json
end

delete '/instances/:id' do
  param = JSON.parse(request.body.read)
  instance_id = params[:id]
  name = param['name']
  user_id = param['token']
  memory = param['memory']
  cpu = param['cpu']
  ssh_id = params[:ssh_id]
  dc = DataCenter.new(user_id)
  data = dc.delete_instance(instance_id)

  data.to_json
end
