//
//  UIImageView+Extension.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

extension UIImageView {
    // MARK: load external images from URL into UIImageView
    func load(url: URL, placeholder: UIImage = #imageLiteral(resourceName: "placeholder")) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.backgroundColor = .white
                        self?.image = placeholder
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.backgroundColor = .white
                    self?.image = placeholder
                }
            }
        }
    }
}
