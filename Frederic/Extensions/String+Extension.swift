//
//  String+Extension.swift
//  Frederic
//
//  Created by Carlos Jimenez on 13-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

extension String {

    public var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: "")
    }

}
