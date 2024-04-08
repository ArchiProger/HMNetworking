# Making requests

## Making requests 

After configuring the client, you can send network requests using its methods. And customize them in a declarative style

```swift
let response = try await client.request("https://www.exapmle.com") {
    // Configure request parameters exposed by HttpRequestBuilder
}
```

## Specify a request URL﻿

Additional setting of the page URL

### Query

```swift
let response = try await client.request("https://www.exapmle.com") {
    Query {
        Parameter(name: "param1", body: 1)              
        Parameter(name: "param2", body: 2)              
        Parameter(name: "param3", body: 3)              
    }
}
```

## Set request parameters﻿

In this section, we'll see how to specify various request parameters, including an HTTP method, headers.

### Specify an HTTP method

When calling the request function, you can specify the desired HTTP method using the ``HttpMethod``:

> It is worth noting that by default the method is `get`

```swift
let response = try await client.request("https://www.exapmle.com") {
    HttpMethod(.post)
}
```

### Headers

To add headers to the request, you can use the following way:

```swift
let response = try await client.request("https://www.exapmle.com") {
    HttpHeaders {
        Header(.contentType("application/json; charset=UTF-8"))
        Header(.defaultUserAgent)
        Header(name: "custom", value: "body")
    }
}
```

## Set request body

To set the request text, you need to use ``HttpBody``. This structure accepts various types of payload, including plain text, instances of arbitrary classes, form data, byte arrays, and so on. Below we will look at some examples.

### Binary data

```swift
let data: Data = ...

let response = try await client.request("https://www.exapmle.com") {
    HttpMethod(.post)
    HttpBody(data: data)
}
```

### Text

```swift
let text = "Hello, World"
let data = text.data(using: .utf8)

guard let data else { throw Exceptios.someException }

let response = try await client.request("https://www.exapmle.com") {
    HttpMethod(.post)
    HttpBody(data: data)
}
```

### Objects

To decode structures to json format, the `Encodable` protocol is used

```swift
struct PostDTO: Encodable {
    var id: Int? = nil
    var title: String
    var body: String
    var userId: Int
}

let post = PostDTO(title: "Data", body: "data serializer", userId: 1)

let response = try await client.request("https://www.exapmle.com") {
    HttpMethod(.post)
    HttpBody(encodable: post)
}
```

### Json

```swift
let response = try await client.request("/posts") {
    HttpMethod(.post)
    HttpBody(json: [
        "title": "Data",
        "body": "data serializer",
        "userId": 1
    ])
}
```
