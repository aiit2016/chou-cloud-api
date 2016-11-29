require 'net/https'

class DataCenter
  def initialize(user_id)
    @user_id = user_id
  end

  def get_all()
    response = request_get('instances/')
    return response
  end

  def get_one(id)
    response = request_get("instances/#{id}")
    return response
  end

  # request creation
  # @param memory [Integer]
  # @param cpu [Integer]
  # @param ssh_key_id [Integer]
  # @return [Integer] vm_id
  def create_instance(name, memory, cpu, ssh_key_id)
    response = request_post('/instances', {
      user_id: @user_id,
      name: name,
      memorySize: memory,
      cpuSize: cpu,
      machineId: 1,
      status: 'running?',
      ssh_key_id: ssh_key_id
    })

    {
      id: response['id'],
      name: response['name'],
      memory: response['memorySize'],
      cpu: response['cpuSize'],
      status: response['status']
    }
  end

  def update_instance(id, update_data)
    data = get_one(id)

    data['name'] = update_data[:name] || data['name']
    data['memorySize'] = update_data[:memory] || data['memorySize']
    data['cpuSize'] = update_data[:cpu] || data['cpuSize']

    response = request_put("/instances/#{id}", data)

    {
      id: response['id'],
      name: response['name'],
      memory: response['memorySize'],
      cpu: response['cpuSize'],
      status: response['status']
    }
  end

  def start_instance(id)
    response = request_post("/instances/#{id}/up", {})
    {
      id: response['id'],
      name: response['name'],
      memory: response['memorySize'],
      cpu: response['cpuSize'],
      status: response['status']
    }
  end

  def stop_instance(id)
    response = request_post("/instances/#{id}/down", {})
    {
      id: response['id'],
      name: response['name'],
      memory: response['memorySize'],
      cpu: response['cpuSize'],
      status: response['status']
    }
  end

  def delete_instance(id)
    response = request_delete("/instances/#{id}")

    if response.code === '200'
      {message: 'OK'}
    else
      {message: 'NG'}
    end
  end

  private
  # mock request
  def request_get(path)
    uri = URI.parse("http://datacenter:8080/#{path}")
    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Get.new(uri.path)

    res = http.request(req)
    JSON.parse(res.body)
  end

  def request_post(path, data)
    uri = URI.parse("http://datacenter:8080/#{path}")
    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Post.new(uri.path)
    req["Content-Type"] = 'application/json'
    req.body = data.to_json

    res = http.request(req)
    JSON.parse(res.body)
  end

  def request_put(path, data)
    uri = URI.parse("http://datacenter:8080/#{path}")
    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Put.new(uri.path)
    req["Content-Type"] = 'application/json'
    req.body = data.to_json

    res = http.request(req)
    JSON.parse(res.body)
  end

  def request_delete(path)
    uri = URI.parse("http://datacenter:8080/#{path}")
    http = Net::HTTP.new(uri.host, uri.port)

    req = Net::HTTP::Delete.new(uri.path)

    http.request(req)
  end
end