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
    @IBOutlet private weak var artistImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.artistImage.layer.cornerRadius = self.artistImage.frame.size.width / 2
        self.artistImage.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.artistImage.image = nil
    }

    func loadArtist(viewModel: Search.Artists.ViewModel) {
        self.artistLabel.text = viewModel.name
        guard let url = FredericAPI.imageURL(id: viewModel.id) else {
            return
        }
        self.artistImage.load(url: url)
    }
}
