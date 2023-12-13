require 'net/http'
require 'uri'

def check_certificate_expiration(url, ca_file)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  http.ca_file = ca_file

  request = Net::HTTP::Get.new(uri.path)
  response = http.request(request)

  expiration_date = OpenSSL::X509::Certificate.new(response.peer_cert).not_after
  "Server Certificate Expiration Date: #{expiration_date}"
end

# Example usage
url = 'https://localhost:8443/'
ca_file = 'ca_cert.pem'

puts check_certificate_expiration(url, ca_file)
