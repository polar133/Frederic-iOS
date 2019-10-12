//
//  FredericError.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

// Describes an networking layer error
//
// - invalidURL: The url is invalid. It should be of type 'www.example.com'var/
// - responseSerialization: The response object was unable to serialize
// - noInternetConection: The request failed due to internet conecction was no available
// - requestTimeOut: The request failed due to it exceded the waiting time
// - unknown: An unknown error
enum FredericError: Error {
    case invalidURL
    case responseSerialization
    case noInternetConection
    case requestTimeOut
    case unknown
}

extension FredericError: Equatable {

    // Transform an underlying request error into  `XSError`
    //
    // - Parameters:
    //   - code: Response code.
    //   - error: An `Error` type.
    //   - content: The content response body
    // - Returns: An new instance of `XSError` describing the failure
    static func from(_ code: Int?, error: Error?, content: Data?) -> FredericError {
        if code == -1009 {
            return .noInternetConection
        } else if code == -1001 || code == -72007 {
            return .requestTimeOut
        } else if code ==  -999 {
            return .requestTimeOut
        } else {
            return .unknown
        }
    }

    public static func == (lhs: FredericError, rhs: FredericError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
