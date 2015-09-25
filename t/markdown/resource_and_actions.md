# NAME

Resource and Actions API

# VERSION

1.0

# DESCRIPTION

This API example demonstrates how to define a resource with multiple actions.

## API Blueprint
+ [Previous: The Simplest API](01.%20Simplest%20API.md)
+ [This: Raw API Blueprint](https://raw.github.com/apiaryio/api-blueprint/master/examples/02.%20Resource%20and%20Actions.md)
+ [Next: Named Resource and Actions](03.%20Named%20Resource%20and%20Actions.md)

# BASEURL

No default URL is defined to this application.

# RESOURCES

## GET /message

Say hello to the world

Here we define an action using the `GET` [HTTP request method](http://www.w3schools.com/tags/ref_httpmethods.asp) for our resource `/message`.

As with every good action it should return a [response](http://www.w3.org/TR/di-gloss/#def-http-response). A response always bears a status code. Code 200 is great as it means all is green. Responding with some data can be a great idea as well so let's add a plain text message to our response.

### Resource URL

    GET http://example.com/message

### Parameters

This resource takes no parameters.

### Responses

#### 200 - OK

The response message

    {
      "example":     "format":   },

## PUT /message

Say hello to the world

OK, let's add another action. This time to put new data to our resource (essentially an update action). We will need to send something in a [request](http://www.w3.org/TR/di-gloss/#def-http-request) and then send a response back confirming the posting was a success (HTTP Status Code 204 ~ Resource updated successfully, no content is returned).

### Resource URL

    PUT http://example.com/message

### Parameters

    .------------------------------------------------------.
    | Name    | In   | Type   | Required | Description     |
    |------------------------------------------------------|
    | message | body | schema | Yes      | No description. |
    '------------------------------------------------------'

    message:

    {
      "example":     "format":   },

### Responses

#### 204 - No Content

The response message

    {
    },

## X-API-BLUEPRINT /message

This is our [resource](http://www.w3.org/TR/di-gloss/#def-resource). It is defined by its [URI](http://www.w3.org/TR/di-gloss/#def-uniform-resource-identifier) or, more precisely, by its [URI Template](http://tools.ietf.org/html/rfc6570).

This resource has no actions specified but we will fix that soon.

### Resource URL

    X-API-BLUEPRINT http://example.com/message

### Parameters

This resource takes no parameters.

### Responses

# COPYRIGHT AND LICENSE

Unknown author

BSD - http://www.linfo.org/bsdlicense.html
