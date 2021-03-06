//
//  SortViewController.swift
//  SkyScanner
//
//  Created by Nisum on 2/4/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

protocol SortViewControllerDelegate {
    func reloadFromSort(sortIndex: Int)
}

class SortViewController: PopUpDetailViewController {

    var sortOptions: [SortOptionViewModel] = []
    var selectedSortOptionIndex: Int = 0
    var delegate: SortViewControllerDelegate?

    init(point: CGPoint, tableViewHeight: CGFloat, sortOptions: [SortOptionViewModel], selectedSortOptionIndex: Int) {
        super.init()
        self.point = point
        self.tableViewHeight = tableViewHeight
        self.sortOptions = sortOptions
        self.selectedSortOptionIndex = selectedSortOptionIndex
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: SortOptionTableViewCell.nibName, bundle: nil),
                                forCellReuseIdentifier: SortOptionTableViewCell.reuseIdentifier)
        prepareAnimation(point: self.point, tableViewHeight: self.tableViewHeight)
        self.tableView.reloadData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SortOptionTableViewCell.reuseIdentifier, for: indexPath) as? SortOptionTableViewCell {
            cell.setup(viewModel: sortOptions[indexPath.row], isSelected: indexPath.row == selectedSortOptionIndex)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SortOptionTableViewCell.getHeight()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismissPopUp()
        self.delegate?.reloadFromSort(sortIndex: indexPath.row)
    }

}
