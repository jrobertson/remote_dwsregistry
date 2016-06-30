# Introducing the remote_dwsregistry gem

To run the following example you would need to run a ?rack_dwsregistry web server http://www.jamesrobertson.eu/snippets/2016/jun/30/introducing-the-rack_dwsregistry-gem.html? on port 9292.


    require 'remote_dwsregistry'

    rreg = RemoteDwsRegistry.new domain: 'localhost', port: '9292'
    rreg.set_key 'app/whiteboard/colour', 'yellow'
    #=> <colour>yellow</colour>

    rreg.get_key 'app/whiteboard/colour'
    #=> <colour>yellow</colour>

The benefit of using the remote_dwsregistry gem instead of the dwsregistry gem is that the XML registry file can be accessed remotely instead of having to ensure access to the local XML registry file.

## Resources

* remote_dwsregistry https://rubygems.org/gems/remote_dwsregistry

remote_dwsregistry dwsregistry remotedwsregistry registry gem


