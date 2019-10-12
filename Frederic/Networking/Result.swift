//
//  Result.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

// MARK: States of networking result
enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
}
