describe port(5432) do
  it { should be_listening  }
end

describe service('postgresql') do
  it { should be_running }
end
