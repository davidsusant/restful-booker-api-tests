Feature: Create Booking
    As a user
    I want to create a new Booking
    So that I can reserve a room

    Scenario: Create a new booking with valid data
        Given I have booking data
        When I send a POST request to "/booking" with the booking data
        Then the response status should be 200
        And the response should contain a bookingid
        