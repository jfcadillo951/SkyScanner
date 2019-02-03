//
//  ItineraryTableViewCell.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class ItineraryTableViewCell: UITableViewCell {

    static let nibName = "ItineraryTableViewCell"
    static let reuseIdentifier = "ItineraryTableViewCell"

    @IBOutlet weak var stackView: UIStackView!
    var outBoundLegView: LegView?
    var inBoundLegView: LegView?

    override func awakeFromNib() {
        super.awakeFromNib()
        outBoundLegView = LegView()
        stackView.insertArrangedSubview(outBoundLegView!, at: 0)
        inBoundLegView = LegView()
        if let leg = inBoundLegView {
            stackView.removeArrangedSubview(leg)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(viewModel: ItineraryViewModel) {
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
        
    }
    
}