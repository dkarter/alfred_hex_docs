# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'
require 'erb'

query = ARGV[0]
encoded_query = ERB::Util.url_encode(query)

uri = URI.parse("https://hex.pm/api/packages?sort=downloads&search=#{encoded_query}")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

req = Net::HTTP::Get.new(uri)

res = http.request(req)

json_resp = JSON.parse(res.body)

script_filter_items = json_resp.map do |result|
  {
    title: result['name'],
    subtitle: result['meta']['description'],
    arg: result['docs_html_url'],
    variables: {
      package_url: result['html_url'],
    },
    quicklookurl: result['docs_html_url'],
  }
end

puts({ items: script_filter_items }.to_json)
