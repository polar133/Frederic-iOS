//
//  ArtistCell.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {

    // MARK: - Properties
    static var nibName: String {
        return String(describing: self)
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    @IBOutlet private weak var artistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func loadArtist(viewModel: Search.Artists.ViewModel) {
        self.artistLabel.text = viewModel.name
    }
}
