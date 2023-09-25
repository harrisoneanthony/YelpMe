//
//  Restaurants.swift
//  YelpMe
//
//  Created by Steven Craig Sickles on 8/12/23.
//

import Foundation

class Businesses: Codable {
    var businesses: [Business]!
}

class Business: Codable {
    var id: String
    var alias: String
    var name: String
    var image_url: String
    var is_closed: Bool
    var url: String
    var review_count: Int
    var categories: [Category]
    var rating: Double
    var coordinates: Coordinate
    var transactions: [String]
//    var price: String
    var location: Location
    var phone: String
    var display_phone: String
    var distance: Double
}

struct Category: Codable {
    var alias: String
    var title: String
}

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Location: Codable {
    var address1: String
    var address2: String?
    var address3: String?
    var city: String
    var zip_code: String
    var country: String
    var state: String
    var display_address: [String]
}
