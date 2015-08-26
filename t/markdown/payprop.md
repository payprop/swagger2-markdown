FORMAT: 1A

# PayProp API Version 1.0
This is an example

# Group Agencies

## Agencies [/api/v1.0/agencies]
A list of agencies linked to the user account

### get all agency details [GET]

+ Parameters

    + username (string, optional) - Search for agencies by username
    + category (string, optional) - Search for agencies by category
    + subdomain (string, optional) - Search for agencies by subdomain
    + currency (string, optional) - Search for agencies by currency
    + country_code (string, optional) - Search for agencies by country code
    + first_line (string, optional) - Search for agencies by first line
    + state (string, optional) - Search for agencies by state
    + city (string, optional) - Search for agencies by city
    + zip_code (string, optional) - Search for agencies by zip code
    + rows (integer, optional) - Restrict rows returned
    + page (integer, optional) - Return given page number

+ Response 200

    + Attributes (object)
        + items (array) - List of agencies



## Agency [/api/v1.0/agencies/{external_id}]
The agency linked to the user account

### get agency details [GET]
Returns the agency linked to the passed external_id

+ Parameters

    + external_id (string) - External ID of agency

+ Response 200

    + Attributes (object)
        + items (array) - List of agencies



# Group Access Token Owner

## Me [/api/v1.0/me]
The details of the user account

### get user details [GET]
The response data will depend on the user type. When the user is linked to an Agency the response will contain the details of that Agency

+ Response 200

    + Attributes (object)
        + agency (object)
        + scopes (array)
        + user (object)


