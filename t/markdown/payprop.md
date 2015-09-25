# NAME

PayProp API Version 1.0

# VERSION

1.0

# DESCRIPTION

This is an example

# BASEURL

[https://example.com/api/v1.0](https://example.com/api/v1.0)

# RESOURCES

## X-API-BLUEPRINT /agencies

Agencies

### Resource URL

    X-API-BLUEPRINT https://example.com/api/v1.0/agencies

### Parameters

This resource takes no parameters.

### Responses

## X-API-BLUEPRINT /agencies/{external_id}

Agency

### Resource URL

    X-API-BLUEPRINT https://example.com/api/v1.0/agencies/{external_id}

### Parameters

This resource takes no parameters.

### Responses

## X-API-BLUEPRINT /me

Me

### Resource URL

    X-API-BLUEPRINT https://example.com/api/v1.0/me

### Parameters

This resource takes no parameters.

### Responses

## from_token

get user details

The response data will depend on the user type. When the user is linked to an Agency the response will contain the details of that Agency

### Resource URL

    GET https://example.com/api/v1.0/me

### Parameters

This resource takes no parameters.

### Responses

#### 200 - OK

Profile information for a user

    {
      "agency":     {
        "id": string, // No description.
        "name": string, // No description.
      },
      "scopes":     [// required
  string, // No description.
        ...
      ]
      "user":     {
        "email_address": string, // Email address of the PayProp user
        "full_name": string, // Full name of the PayProp user.
        "id": string, // ID of the PayProp user.
      },
    },

## get

get agency details

Returns the agency linked to the passed external_id

### Resource URL

    GET https://example.com/api/v1.0/agencies/{external_id}

### Parameters

    .----------------------------------------------------------------.
    | Name        | In   | Type   | Required | Description           |
    |----------------------------------------------------------------|
    | external_id | path | string | Yes      | External ID of agency |
    '----------------------------------------------------------------'

### Responses

#### 200 - OK

A list of agency objects

    {
      "items":     [// List of Agency objects
        {
          "account_status": string, // No description.
          "activation_date": dateTime, // No description.
          "address":         {
            "billing":           {
              "city": string, // No description.
              "country_code": string, // No description.
              "created": dateTime, // No description.
              "email": string, // No description.
              "fax": string, // No description.
              "first_line": string, // No description.
              "id": string, // No description.
              "latitude": string, // No description.
              "longitude": string, // No description.
              "modified": dateTime, // No description.
              "phone": string, // No description.
              "second_line": string, // No description.
              "state": string, // No description.
              "third_line": string, // No description.
              "zip_code": string, // No description.
            },
            "statement":           {
              "city": string, // No description.
              "country_code": string, // No description.
              "created": dateTime, // No description.
              "email": string, // No description.
              "fax": string, // No description.
              "first_line": string, // No description.
              "id": string, // No description.
              "latitude": string, // No description.
              "longitude": string, // No description.
              "modified": dateTime, // No description.
              "phone": string, // No description.
              "second_line": string, // No description.
              "state": string, // No description.
              "third_line": string, // No description.
              "zip_code": string, // No description.
            },
          },
          "affiliation_number": string, // No description.
          "arlan_number": string, // No description.
          "bill_monthly": boolean, // No description.
          "category": string, // No description.
          "company_name": string, // No description.
          "context": string, // No description.
          "country_code": string, // No description.
          "currency": string, // No description.
          "debit_payment_delay": string, // No description.
          "depost_reference_prefix": string, // No description.
          "financial_year_end": dateTime, // No description.
          "formula_fee":         {
            "discount": number, // No description.
            "percentage": number, // No description.
          },
          "id": string, // No description.
          "landlord_statement_day": number, // No description.
          "monthly_turnover": number, // No description.
          "name": string, // No description.
          "name_on_sms": string, // No description.
          "notifications":         {
            "email": boolean, // No description.
            "sms": boolean, // No description.
          },
          "payments":         {
            "enable": boolean, // No description.
            "verify": boolean, // No description.
          },
          "portfolio_size": number, // No description.
          "registration":         {
            "company_number": string, // No description.
            "date": dateTime, // No description.
          },
          "tenant_statement_date": number, // No description.
          "user":         {
            "cell_phone": string, // No description.
            "email": string, // No description.
            "first_name": string, // No description.
            "last_name": string, // No description.
          },
          "username": string, // No description.
          "vat_number": string, // No description.
          "web_address": string, // No description.
        },
        ...
      ]
    },

## get_all

get all agency details

### Resource URL

    GET https://example.com/api/v1.0/agencies

### Parameters

    .---------------------------------------------------------------------------------.
    | Name         | In    | Type    | Required | Description                         |
    |---------------------------------------------------------------------------------|
    | username     | query | string  | No       | Search for agencies by username     |
    | category     | query | string  | No       | Search for agencies by category     |
    | subdomain    | query | string  | No       | Search for agencies by subdomain    |
    | currency     | query | string  | No       | Search for agencies by currency     |
    | country_code | query | string  | No       | Search for agencies by country code |
    | first_line   | query | string  | No       | Search for agencies by first line   |
    | state        | query | string  | No       | Search for agencies by state        |
    | city         | query | string  | No       | Search for agencies by city         |
    | zip_code     | query | string  | No       | Search for agencies by zip code     |
    | rows         | query | integer | No       | Restrict rows returned              |
    | page         | query | integer | No       | Return given page number            |
    '---------------------------------------------------------------------------------'

### Responses

#### 200 - OK

A list of agency objects

    {
      "items":     [// List of Agency objects
        {
          "account_status": string, // No description.
          "activation_date": dateTime, // No description.
          "address":         {
            "billing":           {
              "city": string, // No description.
              "country_code": string, // No description.
              "created": dateTime, // No description.
              "email": string, // No description.
              "fax": string, // No description.
              "first_line": string, // No description.
              "id": string, // No description.
              "latitude": string, // No description.
              "longitude": string, // No description.
              "modified": dateTime, // No description.
              "phone": string, // No description.
              "second_line": string, // No description.
              "state": string, // No description.
              "third_line": string, // No description.
              "zip_code": string, // No description.
            },
            "statement":           {
              "city": string, // No description.
              "country_code": string, // No description.
              "created": dateTime, // No description.
              "email": string, // No description.
              "fax": string, // No description.
              "first_line": string, // No description.
              "id": string, // No description.
              "latitude": string, // No description.
              "longitude": string, // No description.
              "modified": dateTime, // No description.
              "phone": string, // No description.
              "second_line": string, // No description.
              "state": string, // No description.
              "third_line": string, // No description.
              "zip_code": string, // No description.
            },
          },
          "affiliation_number": string, // No description.
          "arlan_number": string, // No description.
          "bill_monthly": boolean, // No description.
          "category": string, // No description.
          "company_name": string, // No description.
          "context": string, // No description.
          "country_code": string, // No description.
          "currency": string, // No description.
          "debit_payment_delay": string, // No description.
          "depost_reference_prefix": string, // No description.
          "financial_year_end": dateTime, // No description.
          "formula_fee":         {
            "discount": number, // No description.
            "percentage": number, // No description.
          },
          "id": string, // No description.
          "landlord_statement_day": number, // No description.
          "monthly_turnover": number, // No description.
          "name": string, // No description.
          "name_on_sms": string, // No description.
          "notifications":         {
            "email": boolean, // No description.
            "sms": boolean, // No description.
          },
          "payments":         {
            "enable": boolean, // No description.
            "verify": boolean, // No description.
          },
          "portfolio_size": number, // No description.
          "registration":         {
            "company_number": string, // No description.
            "date": dateTime, // No description.
          },
          "tenant_statement_date": number, // No description.
          "user":         {
            "cell_phone": string, // No description.
            "email": string, // No description.
            "first_name": string, // No description.
            "last_name": string, // No description.
          },
          "username": string, // No description.
          "vat_number": string, // No description.
          "web_address": string, // No description.
        },
        ...
      ]
    },

# COPYRIGHT AND LICENSE

Unknown author

BSD - http://www.linfo.org/bsdlicense.html
