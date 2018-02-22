# BeyovaJSON

[![Travis CI](https://travis-ci.org/Beyova/BeyovaJSON.svg?branch=master)](https://travis-ci.org/Beyova/BeyovaJSON)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![CocoaPods](https://img.shields.io/cocoapods/v/BeyovaJSON.svg)
![Swift](http://img.shields.io/badge/swift-4.0-brightgreen.svg)

BeyovaJSON allows any json for Coadable in Swift 4.

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

#### Codable

`Codable` is added with Xcode 9, iOS 11 and Swift 4.
It is used to make your data types encodable and decodable for compatibility with external representations such as JSON.

```swift
class Group: Codable {
	var title: String = "Guardians of the Galaxy"
	var members: JSON = [["name": "Star-Lord"],["name": "Groot"],["name": "Rocket"]]
	var date: Date = Date()
}
let group = Group()
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let data = try! encoder.encode(group)
print(String(bytes: data, encoding: .utf8)!)
```











