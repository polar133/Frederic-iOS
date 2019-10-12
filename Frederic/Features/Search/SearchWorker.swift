//
//  SearchWorker.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

class SearchWorker {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func doSearch(callback: @escaping (Result<ArtistsResponse, Error>) -> Void) {
    }
}
