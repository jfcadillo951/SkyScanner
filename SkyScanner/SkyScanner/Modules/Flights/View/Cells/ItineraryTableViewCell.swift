//
//  ItineraryTableViewCell.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import SkeletonView

class ItineraryTableViewCell: UITableViewCell {

    static let nibName = "ItineraryTableViewCell"
    static let reuseIdentifier = "ItineraryTableViewCell"

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var aditionalLabel: UILabel!
    @IBOutlet weak var filterDescriptionLabel: UILabel!
    @IBOutlet weak var lineSeparatorView: UIView!

    @IBOutlet weak var finalPriceLabel: UILabel!
    var outBoundLegView: LegView?
    var inBoundLegView: LegView?

    override func awakeFromNib() {
        super.awakeFromNib()
        outBoundLegView = LegView()
        stackView.insertArrangedSubview(outBoundLegView!, at: 0)
        inBoundLegView = LegView()
        setStyles()
        cleanCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cleanCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setStyles() {
        filterDescriptionLabel.font = UITheme.Fonts.subTitleFont
        filterDescriptionLabel.textColor = UITheme.Colors.filterCellColor
        lineSeparatorView.backgroundColor = UITheme.Colors.backgroudCellColor
        finalPriceLabel.font = UITheme.Fonts.titleFont
        finalPriceLabel.textColor = UITheme.Colors.titleColor
    }

    private func cleanCell() {
        outBoundLegView?.cleanView()
        inBoundLegView?.cleanView()
        aditionalLabel.text = ""
        filterDescriptionLabel.text = ""
    }

    func _setup(viewModel: ItineraryViewModel) {
        if viewModel.inboundLeg != nil {
            if !stackView.arrangedSubviews.contains(inBoundLegView!) {
                stackView.insertArrangedSubview(inBoundLegView!, at: 1)
            }

        } else if stackView.arrangedSubviews.contains(inBoundLegView!) {
            stackView.removeArrangedSubview(inBoundLegView!)
        }

        if let leg = viewModel.outboundLeg {
            outBoundLegView?.setup(viewModel: leg)
        }

        if let leg = viewModel.inboundLeg {
            inBoundLegView?.setup(viewModel: leg)
        }
        filterDescriptionLabel.text = viewModel.priceDescription
        finalPriceLabel.text = viewModel.finalPrice
    }

    func setup(viewModel: ItineraryViewModel) {
        if viewModel.isSkeleton {
            if !stackView.arrangedSubviews.contains(inBoundLegView!) {
                stackView.insertArrangedSubview(inBoundLegView!, at: 1)
            }
            aditionalLabel.showAnimatedSkeleton()
            filterDescriptionLabel.showAnimatedSkeleton()
            finalPriceLabel.showAnimatedSkeleton()
            if let leg = viewModel.outboundLeg {
                outBoundLegView?.setup(viewModel: leg)
            }
            if let leg = viewModel.inboundLeg {
                inBoundLegView?.setup(viewModel: leg)
            }
        } else {
            aditionalLabel.hideSkeleton()
            filterDescriptionLabel.hideSkeleton()
            finalPriceLabel.hideSkeleton()
            _setup(viewModel: viewModel)
        }

    }
    
}
