#!/usr/bin/env ruby

# file: remote_dwsregistry.rb
# description: Used in conjunction with the rack_dwsregistry gem to 
#              remotely get and set keys from the XML based registry.


require 'json'
require 'rexle'
require 'requestor'
require 'gpd-request'


class RemoteDwsRegistry

  def initialize(url2_base=nil, domain: '127.0.0.1', 
                 port: '9292', url_base: "http://#{domain}:#{port}/", 
                 debug: false)

    @url_base = url2_base || url_base
    @url_base += '/' unless url_base[-1] == '/'
    @req = GPDRequest.new
    @debug = debug

  end
  
  def delete_key(key)

    r = @req.get(@url_base + key, {action: 'delete_key'})    

    case r.content_type
    when 'application/json'

      JSON.parse r.body

    else

      r.body
    
    end

  end

  def gem_register(gemfile)
    
    if gemfile =~ /^\w+\:\/\// then
      
      puts 'about to remotely request gemfile' if @debug
      code = Requestor.read(File.dirname(gemfile)) do |x| 
        x.require File.basename(gemfile)
      end
      
      eval code
      
    else
      
      require gemfile
      
    end
    
    if defined? RegGem::register then
      
      reg = RegGem::register
      puts 'importing registry' + reg.inspect
      import reg 
      
    else
      nil
    end
    
  end

  def get_key(key='', auto_detect_type: false)

    r = @req.get(@url_base + key)    
    
    puts 'r.content_type: ' +  r.content_type.inspect if @debug
    
    case r.content_type
    when 'application/xml'

      doc = Rexle.new(r.body)
      e = doc.root
      
     
      if auto_detect_type == false then
        
        def e.to_os()
           OpenStruct.new self.elements.inject({}) \
               {|r,x| r.merge(x.name => x.text) }
        end 
      
        return e         
      end
        
      
      c = e.attributes[:type]
      s = e.text

      return e if e.elements.length > 0 or s.nil?    
      return s.to_s unless c
            
      h = {
        string: ->(x) {x},
        boolean: ->(x){ 
          case x
          when 'true' then true
          when 'false' then false
          when 'on' then true
          when 'off' then false
          else x
          end
        },
        number: ->(x){  x[/^[0-9]+$/] ? x.to_i : x.to_f },
        time:   ->(x) {Time.parse x},
        json:   ->(x) {JSON.parse x}
      }
                              
      h[c.to_sym].call s         

    when 'application/json'

      h = JSON.parse r.body
      return nil if h == {get_key: 'key not found'}

    else

      r.body
    
    end
    
    

  end
  
  def get_keys(key)

    r = @req.get(@url_base + key, {action: 'get_keys'})    

    case r.content_type
    when 'application/xml'

      doc = Rexle.new(r.body)
      
      if doc.root.elements then
        doc.root.elements.to_a 
      else
        []
      end

    when 'application/json'

      JSON.parse r.body

    else

      r.body
    
    end

  end  
  
  def import(s)

    url = @url_base + 'import'

    r = @req.post(url, 's' => s)

    case r.content_type
    when 'application/xml'

      doc = Rexle.new(r.body)
      doc.root

    when 'application/json'

      JSON.parse r.body

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

      JSON.parse r.body

    else

      r.body
    
    end

  end
  
  def xml()
    r = get_key()
    r.xml if r.is_a? Rexle::Element
  end
  
  def xpath(path)
    
    r = @req.get(@url_base, {xpath: path})

    case r.content_type
    when 'application/xml'

      doc = Rexle.new(r.body)
      
      if doc.root.elements then
        doc.root.elements.to_a 
      else
        []
      end

    when 'application/json'

      JSON.parse r.body

    else

      r.body
    
    end
  end  
  
end
