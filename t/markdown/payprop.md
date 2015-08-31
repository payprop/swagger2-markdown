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

+ Response 200 (application/json)

    + Attributes (object)
        + items (array[Agency]) - List of Agency objects



## Agency [/api/v1.0/agencies/{external_id}]
The agency linked to the user account

### get agency details [GET]
Returns the agency linked to the passed external_id

+ Parameters

    + external_id (string) - External ID of agency

+ Response 200 (application/json)

    + Attributes (object)
        + items (array[Agency]) - List of Agency objects



# Group Access Token Owner

## Me [/api/v1.0/me]
The details of the user account

### get user details [GET]
The response data will depend on the user type. When the user is linked to an Agency the response will contain the details of that Agency

+ Response 200 (application/json)

    + Attributes (Profile)


# Data Structures

## Address (object)
+ city (string)
+ country_code (string)
+ created (string)
+ email (string)
+ fax (string)
+ first_line (string)
+ id (string)
+ latitude (string)
+ longitude (string)
+ modified (string)
+ phone (string)
+ second_line (string)
+ state (string)
+ third_line (string)
+ zip_code (string)

## Agency (object)
+ account_status (string)
+ activation_date (string)
+ address (object)
    + billing (Address)
    + statement (Address)
+ affiliation_number (string)
+ arlan_number (string)
+ bill_monthly (boolean)
+ category (string)
+ company_name (string)
+ context (string)
+ country_code (string)
+ currency (string)
+ debit_payment_delay (string)
+ depost_reference_prefix (string)
+ financial_year_end (string)
+ formula_fee (object)
    + discount (number)
    + percentage (number)
+ id (string)
+ landlord_statement_day (number)
+ monthly_turnover (number)
+ name (string)
+ name_on_sms (string)
+ notifications (object)
    + email (boolean)
    + sms (boolean)
+ payments (object)
    + enable (boolean)
    + verify (boolean)
+ portfolio_size (number)
+ registration (object)
    + company_number (string)
    + date (string)
+ tenant_statement_date (number)
+ user (object)
    + cell_phone (string)
    + email (string)
    + first_name (string)
    + last_name (string)
+ username (string)
+ vat_number (string)
+ web_address (string)

## Error (string)

## Profile (object)
+ agency (object)
    + id (string)
    + name (string)
+ scopes (array[string])
+ user (User)

## User (object)
+ email_address: `foo@bar.com` (string) - Email address of the PayProp user
+ full_name: `John Smith` (string) - Full name of the PayProp user.
+ id: `jfdks03w` (string) - ID of the PayProp user.

