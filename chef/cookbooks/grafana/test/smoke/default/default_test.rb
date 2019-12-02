# Skipped test
describe port(8083), :skip do
  it {should be_listening }
end
# Grafana
describe port(3000) do
  it { should be_listening }
end

describe service('grafana') do
  it { should be_running }
end

# InfluxDB
describe port(8088) do
  it {should be_listening }
end

describe service('influxdb') do
  it { should be_running }
end
