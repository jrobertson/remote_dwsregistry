Gem::Specification.new do |s|
  s.name = 'remote_dwsregistry'
  s.version = '0.4.0'
  s.summary = 'Used in conjunction with the rack_dwsregistry gem to ' + 
      'remotely get and set keys from the XML based registry.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/remote_dwsregistry.rb']
  s.add_runtime_dependency('rexle', '~> 1.4', '>=1.4.13')
  s.add_runtime_dependency('gpd-request', '~> 0.3', '>=0.3.0')
  s.add_runtime_dependency('requestor', '~> 0.2', '>=0.2.1') 
  s.signing_key = '../privatekeys/remote_dwsregistry.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/remote_dwsregistry'
end
