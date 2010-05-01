require 'rubygems'
require 'restclient'

class OrangewireSender
  @@host_url = nil

  class << self
    def notify(headline, summary)
      resource.post({ :headline => headline, :summary  => summary })
    end

    def resource
      raise "Please set OrangewireSender.host_url to the Orangewire url (example: http://localhost:3000)" unless @@host_url
      @resource ||= RestClient::Resource.new("#{@@host_url}/notifications")
    end

    def host_url=(url)
      @@host_url = url
    end
  end
end

