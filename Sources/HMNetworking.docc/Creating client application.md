# Creating client application

## Creating a simple application

> To create a client application and send network requests, use ``HttpClient``

```swift
let client = HttpClient()
```

## Making requests

```swift
let response = try await client.request()
```
