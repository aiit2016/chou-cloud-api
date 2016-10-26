require 'net/https'

class DataCenter
  def initialize(user_id)
    @user_id = user_id
  end

  def get_all()
    response = request(:get_all, {
      user_id: @user_id
    })

    [
      {
        instance_id: 11,
        user_id: @user_id,
        status: 'running',
        memory: 1,
        cpu: 1
      },
      {
        instance_id: 22,
        user_id: @user_id,
        status: 'creating',
        memory: 2,
        cpu: 2
      },
    ]
  end

  # request creation
  # @param memory [Integer]
  # @param cpu [Integer]
  # @param ssh_key_id [Integer]
  # @return [Integer] vm_id
  def create_instance(memory, cpu, ssh_key_id)
    response = request(:create_vm, {
      user_id: @user_id,
      memory: memory,
      cpu: cpu,
      ssh_key_id: ssh_key_id
    })

    {
      id: 12,
      user_id: @user_id,
      memory: memory,
      cpu: cpu,
      ssh_key_id: ssh_key_id
    }
  end

  private
  # mock request
  def request(instruction, data)

    uri = URI.parse("https://localhost:8080")
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({'name' => 'hoge', 'content' => 'hogehoge'})

    res = http.request(req)

  end
end