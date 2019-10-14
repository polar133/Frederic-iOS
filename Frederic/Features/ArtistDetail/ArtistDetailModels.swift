//
//  ArtistDetailModels.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

enum ArtistDetail {
    // MARK: Use cases

    enum Profile {
        struct Request {
        }
        struct Response {
            let artist: Artist
        }
        struct ViewModel {
            let id: Int
            let name: String
        }
    }
}
