Feature: Get Booking
    As a user
    I want to retrieve booking details
    So that I can view reservation information

    Scenario: Get booking details with valid ID
        Given I have a valid booking ID
        When I send a GET request to "/booking/<bookingid>"
        Then the response status should be 200
        And the response should contain the booking details
        