//
//  Review.swift
//  Review
//
//  Created by Satish Bandaru on 14/09/21.
//

import Foundation

struct ReviewResponse: Codable {
    var results: [Review]
}

struct Review: Codable, Identifiable {
    var id: String?
    var author: String?
    var content: String?
}
