//
//  LegView.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class LegView: UIView {

    @IBOutlet weak var customImageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    @IBOutlet weak var segmentDescriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setStyles()
    }

    func setStyles() {
        titleLabel.font = UITheme.Fonts.titleFont
        titleLabel.textColor = UITheme.Colors.titleColor
        subTitleLabel.font = UITheme.Fonts.subTitleFont
        subTitleLabel.textColor = UITheme.Colors.subTitleColor
        segmentDescriptionLabel.font = UITheme.Fonts.titleFont
        segmentDescriptionLabel.textColor = UITheme.Colors.titleColor
        durationLabel.font = UITheme.Fonts.subTitleFont
        durationLabel.textColor = UITheme.Colors.subTitleColor
    }

    func cleanView() {
        customImageView.image = nil
        self.segmentDescriptionLabel.text = ""
        self.durationLabel.text = ""
        self.titleLabel.text = ""
    }

    func setup(viewModel: LegViewModel) {
        customImageView.loadImageUsingUrlString(urlString: viewModel.legUrl ?? "")
        if viewModel.segmentsCount ?? 0 <= 1 {
            segmentDescriptionLabel.text = "Direct"
            // change color
        } else {
            segmentDescriptionLabel.text = String((viewModel.segmentsCount ?? 0) - 1) + " stops"
            // change color
        }
        self.durationLabel.text = viewModel.duration
        self.titleLabel.text = (viewModel.originPlace ?? "") + " - " + (viewModel.destinationPlace ?? "")

    }

}
