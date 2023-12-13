require 'openssl'

def generate_ca
  key = OpenSSL::PKey::RSA.new(2048)
  cert = OpenSSL::X509::Certificate.new

  cert.version = 2
  cert.serial = 1
  cert.subject = OpenSSL::X509::Name.parse("/C=US/O=MyCA/CN=MyCA Root Certificate")
  cert.issuer = cert.subject
  cert.public_key = key.public_key
  cert.not_before = Time.now
  cert.not_after = cert.not_before + 365 * 24 * 60 * 60 # 1 year
  cert.sign(key, OpenSSL::Digest::SHA256.new)

  [key, cert]
end

def generate_certificate(ca_key, ca_cert, common_name)
  key = OpenSSL::PKey::RSA.new(2048)
  cert = OpenSSL::X509::Certificate.new

  cert.version = 2
  cert.serial = 2
  cert.subject = OpenSSL::X509::Name.parse("/C=US/O=MyCA/CN=#{common_name}")
  cert.issuer = ca_cert.subject
  cert.public_key = key.public_key
  cert.not_before = Time.now
  cert.not_after = cert.not_before + 365 * 24 * 60 * 60 # 1 year
  cert.sign(ca_key, OpenSSL::Digest::SHA256.new)

  [key, cert]
end

# Example usage
ca_key, ca_cert = generate_ca
server_key, server_cert = generate_certificate(ca_key, ca_cert, 'example.com')

File.write('ssl_management/ca_key.pem', ca_key.to_pem)
File.write('ssl_management/ca_cert.pem', ca_cert.to_pem)
File.write('ssl_management/server_key.pem', server_key.to_pem)
File.write('ssl_management/server_cert.pem', server_cert.to_pem)
