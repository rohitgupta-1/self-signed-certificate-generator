require 'webrick'
require 'webrick/https'
require 'openssl'

server = WEBrick::HTTPServer.new(
  Port: 8443,
  SSLEnable: true,
  SSLCertName: [['CN', WEBrick::Utils::getservername]],
  SSLPrivateKey: OpenSSL::PKey::RSA.new(File.read('server_key.pem')),
  SSLCertificate: OpenSSL::X509::Certificate.new(File.read('server_cert.pem'))
)

trap('INT') { server.shutdown }

server.mount_proc '/' do |req, res|
  res.body = "Certificate Expiration Date: #{server.config[:SSLCertificate].not_after}"
end

server.start
