Given('I have booking data') do
  @booking_data = {
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    totalprice: Faker::Number.between(from: 100, to: 1000),
    depositpaid: true,
    bookingdates: {
      checkin: (Date.today + 1).to_s,
      checkout: (Date.today + 5).to_s
    },
    additionalneeds: Faker::Lorem.word
  }
end

When('I send a POST request to {string} with the booking data') do |endpoint|
  @response = create_booking(@booking_data)
end

Then('the response status should be {int}') do |status_code|
  expect(@response.code).to eql(status_code)  
end

Then('the response should contain a bookingid') do
  expect(@response.parsed_response).to have_key('bookingid')
  @booking_id = @response.parsed_response['bookingid']
end

Given('I have a valid booking ID') do
  # Create a booking first to get a valid ID
  booking_data = {
    firstname: 'Test',
    lastname: 'User',
    totalprice: 200,
    depositpaid: true,
    bookingdates: {
      checkin: '2023-01-01',
      checkout: '2023-01-05'
    },
    additionalneeds: 'breakfast'
  }
  response = create_booking(booking_data)
  @booking_id = response.parsed_response['bookingid']
end

When('I send a GET request to {string}') do |endpoint|
  endpoint = endpoint.gsub('<bookingid>', @booking_id.to_s)
  @response = get_booking(@booking_id)
end

Then('the response should contain the booking details') do
  expect(@response.parsed_response).to include(
    'firstname' => be_a(String),
    'lastname' => be_a(String)
  ) 
end

Given('I am authenticated as {string} with password {string}') do |username, password|
  @auth_response = authenticate(username, password)
  expect(@auth_response.code).to eq(200)
  @token = @auth_response.parsed_response['token']
end

Given('I have updated booking data') do
  @updated_booking_data = {
    firstname: 'Updated', 
    lastname: 'User',
    totalprice: 250,
    depositpaid: false,
    bookingdates: {
      checkin: '2023-02-01',
      checkout: '2023-02-05'
    },
    additionalneeds: 'Lunch'
  }
end

When('I send a PUT request to {string} with the updated data') do |endpoint|
endpoint = endpoint.gsub('<bookingid>', @booking_id.to_s)
@response = update_booking(@booking_id, @updated_booking_data, @token)
end

Then('the response should contain the updated booking details') do
  expect(@response.parsed_response).to include(
    'firstname' => 'Updated',
    'lastname' => 'User'
  ) 
end

When('I send a DELETE request to {string}') do |endpoint|
  endpoint = endpoint.gsub('<bookingid>', @booking_id.to_s)
  @response = delete_booking(@booking_id, @token)
end

Then('the booking should no longer exist') do
  response = get_booking(@booking_id)
  expect(response.code).to eq(404) 
end
