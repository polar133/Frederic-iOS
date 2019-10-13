//
//  EmptyView.swift
//  Frederic
//
//  Created by Carlos Jimenez on 13-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit
import Lottie

class EmptyView: UIView {

    private var contentView: UIView?
    private let musicAnimation = AnimationView(name: "music")
    @IBOutlet private weak var musicView: AnimationView!
    @IBOutlet private weak var emptyLabel: UILabel!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    // MARK: - Load xib
    private func xibSetup() {
        let nib = UINib(nibName: String(describing: EmptyView.classForCoder()), bundle: Bundle.main)
        let contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? UIView()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        self.contentView = contentView
        buildAnimation()
    }

    func setEmptyMessage(_ text: String) {
        emptyLabel.text = text
    }

    private func buildAnimation() {
        musicAnimation.contentMode = .scaleAspectFill
        self.musicView.addSubview(musicAnimation)
        musicAnimation.updateConstraints()
        musicAnimation.frame = self.musicView.bounds
        musicAnimation.loopMode = .loop

    }

    func startAnimation() {
        musicAnimation.play()
    }

    func stopAnimation () {
        musicAnimation.stop()
    }
}
