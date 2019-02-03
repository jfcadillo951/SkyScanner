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
    @IBOutlet weak var segmentDescriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setup(viewModel: LegViewModel) {
        customImageView.loadImageUsingUrlString(urlString: viewModel.legUrl ?? "")
        if viewModel.segmentsCount ?? 0 == 0 {
            segmentDescriptionLabel.text = "Direct"
            // change color
        } else {
            segmentDescriptionLabel.text = String((viewModel.segmentsCount ?? 0) - 1) + " stops"
            // change color
        }

    }

}
