#!/usr/bin/env ruby

# file: remote_dwsregistry.rb
# description: Used in conjunction with the rack_dwsregistry gem to remotely get and set keys from the XML based registry.


require 'json'
require 'rexle'
require 'gpd-request'


class RemoteDwsRegistry

  def initialize(url_base='http://127.0.0.1:9292/')

    @url_base = url_base
    @url_base += '/' unless url_base[-1] == '/'
    @req = GPDRequest.new
  end

  def get_key(key)

    r = @req.get(@url_base + key)    

    case r.content_type
    when 'application/xml'

      doc = Rexle.new(r.body)
      doc.root

    when 'application/json'

      r.body.to_json

    else

      r.body
    
    end

  end

  def set_key(key, val)

    url = @url_base + key

    r = @req.post(url, 'v' => val)

    case r.content_type
    when 'application/xml'

      doc = Rexle.new(r.body)
      doc.root

    when 'application/json'

      r.body.to_json

    else

      r.body
    
    end

  end
end
