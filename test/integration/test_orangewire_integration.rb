require 'teststrap'
require 'rest_client'

class Riot::Situation

  def ow_index
    response = RestClient.get 'http://localhost:3000/notifications'
    Nokogiri::HTML(response)
  end
end

context "OrangewireSender" do

  setup do
    # TODO initialize orangewire server instance before each test
    OrangewireSender.host_url = "http://localhost:3000"
    OrangewireSender.login    = "test@testing.com"
    OrangewireSender.password = "tester"

    summary = "SUMMARY: #{Time.now.to_s}"
    OrangewireSender.notify("TRA LA", summary)
    summary
  end

  asserts "appropriately contains text of first notification's summary" do
    html = ow_index
    html.css(".notification .summary").first.text == topic
  end
end