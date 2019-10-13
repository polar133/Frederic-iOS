//
//  SearchWorker.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

class SearchWorker {

    private let urlSession: URLSession
    private var task: URLSessionTask?

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func doSearch(search: String, callback: @escaping (Result<ArtistsResponse>) -> Void) {
        let params = [
            "term": search
        ]
        guard var url = URLComponents(string: FredericAPI.search) else {
            callback(.failure(FredericError.invalidURL))
            return
        }
        url.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        url.percentEncodedQuery = url.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let urlRequest = url.url else {
            callback(.failure(FredericError.invalidURL))
            return
        }
        task?.cancel()
        task = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            let response = response as? HTTPURLResponse
            if let error = error {
                // if task was cancelled, don't trigger an failure callback
                guard (error as NSError).code != NSURLErrorCancelled else {
                    return
                }
            }
            if let data = data, let response = response, (200..<299).contains(response.statusCode) {
                do {
                    let value = try JSONDecoder().decode(ArtistsResponse.self, from: data)
                    callback(.success(value))
                } catch {
                    callback(.failure(FredericError.responseSerialization))
                }
            } else {
                callback(.failure(FredericError.from(response?.statusCode, error: error, content: data)))
            }
        })
        task?.resume()
    }
}
