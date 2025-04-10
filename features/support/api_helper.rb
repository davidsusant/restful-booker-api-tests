# features/support/api_helper.rb
require 'base64'

module APIHelper
  def create_booking(payload)
    HTTParty.post(
      "#{BASE_URL}/booking",
      body: payload.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    )
  end

  def get_booking(booking_id)
    HTTParty.get(
      "#{BASE_URL}/booking/#{booking_id}",
      headers: {
        'Accept' => 'application/json'
      }
    )
  end

  def update_booking(booking_id, payload, token)
    HTTParty.put(
      "#{BASE_URL}/booking/#{booking_id}",
      body: payload.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Cookie' => "token=#{token}"
      }
    )
  end

  def delete_booking(booking_id, token)
    auth = Base64.strict_encode64("#{ENV['BOOKER_USERNAME']}:#{ENV['BOOKER_PASSWORD']}")
    HTTParty.delete(
      "#{BASE_URL}/booking/#{booking_id}",
      headers: {
        'Cookie' => "token#{token}",
        'Authorization' => "Basic #{auth}"
      }
    )
  end

  def authenticate(username, password)
    HTTParty.post(
      "#{BASE_URL}/auth",
      body: { username: username, password: password }.to_json,
      headers: {
        'Content-Type' => 'application/json'
      }
    )
  end
end

World(APIHelper)
