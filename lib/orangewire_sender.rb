require 'rubygems'
require 'restclient'
require 'orangewire/errors'

class OrangewireSender
  @@host_url  = nil
  @@login     = nil
  @@password  = nil

  class << self
    def notify(headline, summary)
      begin
        resource.post({ :headline => headline, :summary  => summary, :login => @@login, :password => @@password })
      rescue Orangewire::Base => b
        raise b
      rescue
        raise Orangewire::ConnectionError, "Error posting to #{@@host_url}", $@
      end
    end

    def resource
      raise Orangewire::ConfigError, "Please set host_url, login and password" unless valid_config?
      @resource ||= RestClient::Resource.new("#{@@host_url}/notifications")
    end

    def host_url=(url)
      @@host_url = url
    end

    def login=(login)
      @@login = login
    end

    def password=(password)
      @@password = password
    end

  private
    def valid_config?
      @@host_url && @@login && @@password
    end
  end
end

