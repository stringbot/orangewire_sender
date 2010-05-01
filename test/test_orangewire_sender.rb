require 'teststrap'

context "OrangewireSender" do
  setup { OrangewireSender }

  asserts_topic "class exists"

  context "with a legit config" do
    hookup do
      OrangewireSender.host_url = "http://localhost:3000"
    end

    context "sending messages" do
      setup do
        mock.instance_of(RestClient::Resource).post(anything) { "post was called" }
        topic.notify("hey", "ya")
      end
      asserts_topic("return value from mock").equals "post was called"
    end
  end

  context "with no config" do
    hookup { topic.host_url = nil }
    asserts("notify") { topic.notify("hey", "ya") }.raises(RuntimeError, /host/)
  end


end

