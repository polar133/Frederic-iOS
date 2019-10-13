//
//  LoadingView.swift
//  Frederic
//
//  Created by Carlos Jimenez on 13-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {

    static let height: CGFloat = 3

    private var contentView: UIView?
    private let loadingAnimation = AnimationView(name: "loading")
    @IBOutlet private weak var loadingView: AnimationView!

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
        let nib = UINib(nibName: String(describing: LoadingView.classForCoder()), bundle: Bundle.main)
        let contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? UIView()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        self.contentView = contentView
        buildAnimation()
    }

    private func buildAnimation() {
        loadingAnimation.contentMode = .center
        self.loadingView.addSubview(loadingAnimation)
        loadingAnimation.updateConstraints()
        loadingAnimation.frame = self.loadingView.bounds
        loadingAnimation.loopMode = .loop
    }

    func startLoading() {
        loadingAnimation.play()
    }

    func stopLoading() {
        loadingAnimation.stop()
    }
}
