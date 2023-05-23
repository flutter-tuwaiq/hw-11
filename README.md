# Backend Assignment in Dart

This assignment focuses on building a backend application using Dart. The application provides various endpoints to handle user account management, user profiles, and contact management. 

`Notes`: 
* use **Supabase**
* use best practices

## Endpoints

### `/create-account` => POST

Creates a new user account by providing the following information:

- `name`: The name of the user.
- `email`: The email address of the user.
- `username`: The username chosen by the user.
- `bio`: A brief description or biography of the user.

### `/login` => POST

Logs in a user by providing authentication tokens:

- `token`: The authentication token.
- `refresh token`: The refresh token used for renewing authentication.

### `/profile` => GET

Retrieves the user profile information:

- `name`: The name of the user.
- `username`: The username of the user.
- `email`: The email address of the user.
- `bio`: The user's biography or description.

### `/edit-profile` => POST

Updates the user profile with new information:

- `name`: The updated name of the user.
- `email`: The updated email address of the user.
- `bio`: The updated biography or description of the user.

### `/contact/add` => POST

Adds a new contact to the user's contact list.

### `/contact/delete/id` => DELETE

Deletes a contact from the user's contact list based on the provided contact ID.

### `/contact/id` => GET

Retrieves the contact information for a specific contact ID.

### `/contact` => GET

Retrieves all contacts in the user's contact list.

### `/user/id` => GET

Retrieves user information based on the provided user ID.

# Deadline

24/5/2023 10:00 AM
