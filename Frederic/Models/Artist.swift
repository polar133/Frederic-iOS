//
//  Artist.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

struct Persons {
    let persons: [Artist]
}

struct Artist {
    let id: Int
    let forename: String
    let surname: String
    let name: String
    let functions: [String]
    let popularity: Double?
    let score: Double?
    let kind: String?
}

extension Persons: Equatable, Decodable {
}

extension Artist: Equatable, Codable {
}
