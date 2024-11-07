Functionality of the presentation layer:
1. Sign in
2. Sign out

Functionality of the buisness-layer:
1. Sign in
2. Sign out
3. refresh token
4. redirect to login if refresh token is invalid

Functionality of the data-layer:
1. sign in and save tokens
2. Retrieve user data
3. refresh access token

Additional functionality:
1. Custom Dio client for handling requests that needs to be authorized
2. Custom Dio client for handling requests that automatically refreshes the access token if it expired
3. Custom Dio client for handling requests that automatically refreshes the access token if it expired and redirects to login if refresh token is invalid

How to 