Gem::Specification.new do |s|
  s.name = 'remote_dwsregistry'
  s.version = '0.1.0'
  s.summary = 'Used in conjunction with the rack_dwsregistry gem to remotely get and set keys from the XML based registry.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/remote_dwsregistry.rb']
  s.add_runtime_dependency('rexle', '~> 1.3', '>=1.3.29')
  s.add_runtime_dependency('gpd-request', '~> 0.2', '>=0.2.6') 
  s.signing_key = '../privatekeys/remote_dwsregistry.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/remote_dwsregistry'
end
