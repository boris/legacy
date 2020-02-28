require 'httparty'
require 'json'

class BtcPrice
    include HTTParty
    format :json
end

def strip_trailing_zero(n)
    n.to_s.sub(/\.\d+$/, '')
end

def thousand_clp(n)
    n.to_s.reverse.gsub(/...(?=.)/,'\&.').reverse
end

url = 'https://api.coindesk.com/v1/bpi/currentprice/CNY.json'
response = BtcPrice.get(url)

data = JSON.parse(response.body)

price = data['bpi']['USD']['rate']


clp_url = 'https://www.buda.com/api/v2/markets/btc-clp/ticker.json'
clp_response = BtcPrice.get(clp_url)

clp_data = JSON.parse(clp_response.body)
clp_price = clp_data['ticker']['last_price'].first

puts "$" + strip_trailing_zero(price) + " USD - $" + thousand_clp(strip_trailing_zero(clp_price)) + " CLP"
