Feature: Delete Booking
    As an authenticated user
    I want to delete a booking
    So that I can cancel a reservation

    Background:
        Given I am authenticated as "admin" with password "password123"

    Scenario: Delete booking with valid ID
        Given I have a valid booking ID
        When I send a DELETE request to "/booking/<bookingid>"
        Then the response status should be 201
        And the booking should no longer exist
        