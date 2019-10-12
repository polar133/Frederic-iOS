//
//  SearchModels.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

typealias ArtistsResponse = Search.Artists.Response

enum Search {

    // MARK: Use cases
    enum Artists {
        struct Request {
            let search: String
        }
        struct Response: Decodable {
            let artists: Persons
        }
        struct ViewModel {
        }
    }
}
