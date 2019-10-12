//
//  FredericAPI.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

enum FredericAPI {

    fileprivate static var baseConfigurationDictionary: [String: Any] {
        let bundle = Bundle.main
        guard let resourcePath = bundle.url(forResource: "API", withExtension: "plist"), let data = try? Data(contentsOf: resourcePath) else {
            return [:]
        }
        do {
            return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }

    fileprivate static func configurationValueForKeyAndSubKey(key: String, subKey: String, baseConfigurationDictionary: [String: Any]) -> String {
        return baseConfigurationDictionary[key] as? String ?? ""
    }

    fileprivate static var baseURL: String {
        return configurationValueForKeyAndSubKey(key: "base_url", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }

    fileprivate static var version: String {
        return configurationValueForKeyAndSubKey(key: "version", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }

    fileprivate static var path: String {
        return configurationValueForKeyAndSubKey(key: "path", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }

    static var search: String {
        let endpoint = configurationValueForKeyAndSubKey(key: "search", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
        return "\(baseURL)/\(version)/\(path)/\(endpoint)"
    }

}
