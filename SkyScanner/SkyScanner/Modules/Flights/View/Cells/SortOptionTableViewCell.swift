//
//  SortOptionTableViewCell.swift
//  SkyScanner
//
//  Created by Nisum on 2/4/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class SortOptionTableViewCell: UITableViewCell {

    static let nibName = "SortOptionTableViewCell"
    static let reuseIdentifier = "SortOptionTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.textColor = UITheme.Colors.optionColor
        self.titleLabel.font = UITheme.Fonts.subTitleFont
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        iconImageView.image = nil
    }

    func setup(viewModel: SortOptionViewModel) {
        self.titleLabel.text = viewModel.name
    }

    static func getHeight() -> CGFloat {
        return 40.0
    }
    
}
