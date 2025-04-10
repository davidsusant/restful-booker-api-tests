Feature: Update booking
    As an authenticated user
    I want to update a booking
    So that I can modify reservation details

    Background:
        Given I am authenticated as "admin" with password "password123"

        Scenario: Update booking with valid data
            Given I have a valid booking ID
            And I have updated booking data
            When I send a PUT request to "/booking/<bookingid>" with the updated data
            Then the response status should be 200
            And the response should contain the updated booking details
            