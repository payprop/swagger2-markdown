# NAME

Grouping Resources API

# VERSION

1.0

# DESCRIPTION

This API example demonstrates how to group resources and form **groups of resources**. You can create as many or as few groups as you like. If you do not create any group all your resources will be part of an "unnamed" group.

## API Blueprint
+ [Previous: Named Resource and Actions](03.%20Named%20Resource%20and%20Actions.md)
+ [This: Raw API Blueprint](https://raw.github.com/apiaryio/api-blueprint/master/examples/04.%20Grouping%20Resources.md)
+ [Next: Responses](05.%20Responses.md)

# BASEURL

No default URL is defined to this application.

# RESOURCES

## GET /message

Retrieve a Message

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

Update a Message

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

My Message

Group of all messages-related resources.

This is the first group of resources in this document. It is **recognized** by the **keyword `group`** and its name is `Messages`.

Any following resource definition is considered to be a part of this group until another group is defined. It is **customary** to increase header level of resources (and actions) nested under a resource.

### Resource URL

    X-API-BLUEPRINT http://example.com/message

### Parameters

This resource takes no parameters.

### Responses

## X-API-BLUEPRINT /users

My User

Group of all user-related resources.

This is the second group in this blueprint. For now, no resources were defined here and as such we will omit it from the next installement of this course.

### Resource URL

    X-API-BLUEPRINT http://example.com/users

### Parameters

This resource takes no parameters.

### Responses

# COPYRIGHT AND LICENSE

Unknown author

BSD - http://www.linfo.org/bsdlicense.html
