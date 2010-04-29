require 'rubygems'
require 'restclient'

class OrangewireSender
  @@hostname = "http://localhost:3000"

  class << self
    def notify(headline, summary)
      resource.post({ :headline => headline, :summary  => summary })
    end

    def resource
      @resource ||= RestClient::Resource.new("#{@@hostname}/notifications")
    end
  end
end

