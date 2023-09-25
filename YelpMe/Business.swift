//
//  Business.swift
//  YelpMe
//
//  Created by Harrison Anthony on 8/2/23.
//

import UIKit

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
}

struct Category: Codable {
    var alias: String
    var title: String
}
