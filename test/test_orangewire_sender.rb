require 'teststrap'

context "OrangewireSender" do
  setup { OrangewireSender }

  asserts_topic "class exists"

  context "with a legit config" do
    hookup do
      OrangewireSender.host_url = "http://fakehost.hxx"
      OrangewireSender.login    = "login"
      OrangewireSender.password = "password"
    end

    context "sending messages" do
      setup do
        mock.any_instance_of(RestClient::Resource).post(anything) { "post was called" }
        topic.notify("hey", "ya")
      end
      asserts_topic("return value from mock").equals "post was called"
    end

    context "except for host_url" do
      hookup { topic.host_url = nil }
      asserts("notify") { topic.notify("hey", "ya") }.raises(Orangewire::ConfigError, /host_url/)
    end

    context "except for login" do
      hookup { topic.login = nil }
      asserts("notify") { topic.notify("what", "now") }.raises(Orangewire::ConfigError, /login/)
    end

    context "except for password" do
      hookup { topic.password = nil }
      asserts("notify") { topic.notify("no", "dice") }.raises(Orangewire::ConfigError, /password/)
    end

    context "connecting to bad endpoint" do
      hookup { topic.host_url = "http://foo.gaz" }
      asserts("nofify") { topic.notify("what", "up") }.raises(Orangewire::ConnectionError, /Error posting to http:\/\/foo\.gaz/)
    end

  end


end

