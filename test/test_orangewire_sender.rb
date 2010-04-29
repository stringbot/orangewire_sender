require 'teststrap'

context "OrangewireSender" do
  setup { OrangewireSender }

  hookup do
    mock.instance_of(RestClient::Resource).post(anything) { "post was called" }
  end

  asserts_topic "exists"

  context "sending messages" do
    setup { topic.notify("hey", "ya") }
    asserts_topic.equals "post was called"
  end
end

