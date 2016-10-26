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
    # do nothing
    {}
  end
end