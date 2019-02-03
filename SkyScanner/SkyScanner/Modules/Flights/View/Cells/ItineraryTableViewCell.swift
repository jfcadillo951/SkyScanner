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
    var outBoundLeg: LegView?
    var inBoundLeg: LegView?

    override func awakeFromNib() {
        super.awakeFromNib()
        outBoundLeg = LegView()
        stackView.insertArrangedSubview(outBoundLeg!, at: 0)
        inBoundLeg = LegView()
        if let leg = inBoundLeg {
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

    func setup(data: Itinerary) {
        if data.inboundLegId != nil {
            if !stackView.arrangedSubviews.contains(inBoundLeg!) {
                stackView.insertArrangedSubview(inBoundLeg!, at: 1)
            }

        } else if stackView.arrangedSubviews.contains(inBoundLeg!) {
            stackView.removeArrangedSubview(inBoundLeg!)
        }
    }
    
}
