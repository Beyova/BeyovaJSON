# BeyovaJSON

[![Travis CI](https://travis-ci.org/Beyova/BeyovaJSON.svg?branch=master)](https://travis-ci.org/Beyova/BeyovaJSON)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![CocoaPods](https://img.shields.io/cocoapods/v/BeyovaJSON.svg)
![Swift](http://img.shields.io/badge/swift-4.0-brightgreen.svg)

BeyovaJSON makes it easier to deal with JSON and Coadable in Swift 4.
Inspired by [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## Installation

#### CocoaPods

```ruby
pod 'BeyovaJSON'
```

#### Carthage

```
github "Beyova/BeyovaJSON"
```

## Usage

```swift
import BeyovaJSON
```

#### Getter

```swift
let users = JToken(rawData: dataFromNetworking)
if let name = users[0]["name"].string {
	//got the name
}
```

Boundary check for conversion in Swift is kept:
```swift
let value: JToken = 9999
print(value.int8Value) // fatal error
```

#### Setter

```swift
let users = JToken(rawData: dataFromNetworking)
users[0]["name"] = JToken.init("John")
```

#### Expressible

```swift
let users: JToken = [["name": "Tom"],["name": "Jerry"]]
users[0]["name"] = "John"
```

#### Codable

`Codable` is added with Xcode 9, iOS 11 and Swift 4.
It is used to make your data types encodable and decodable for compatibility with external representations such as JSON.

`Date` and `Data` are also supported by BeyovaJSON in line with `Codable`.

```swift
class Group: Codable {
	var title: String = "Guardians of the Galaxy"
	var users: JToken = [["name": "Star-Lord"],["name": "Groot"],["name": "Rocket"]]
	var date: Date = Date()
}
let group = Group()
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let data = try! encoder.encode(group)
print(String(bytes: data, encoding: .utf8)!)
```











