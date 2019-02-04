//
//  FlightLivePricesViewController.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol FlightLivePricesViewProtocol {
    func showItineraries(viewModel: [ItineraryViewModel], indexPaths: [IndexPath])
    func showSortOptions(viewModel: [SortOptionViewModel], selectedIndex: Int, in point: CGPoint)
    func showLoading()
    func dismissLoading()
    func stopDisplayResults()
}
class FlightLivePricesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: [ItineraryViewModel]?
    var presenter: FlightsLivePricesPresenterProtocol?
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var navigationSubTitleLabel: UILabel!
    @IBOutlet weak var navigationDescriptionLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    var hud: JGProgressHUD?

    convenience init() {
        self.init(nibName: "FlightLivePricesViewController", bundle: nil)
        setup()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }


    func setup() {
        presenter = FlightLivePricesPresenter(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitleLabel.font = UITheme.Fonts.titleFont
        self.navigationTitleLabel.textColor = UITheme.Colors.titleColor
        self.navigationSubTitleLabel.font = UITheme.Fonts.subTitleFont
        self.navigationSubTitleLabel.textColor = UITheme.Colors.subTitleColor
        self.navigationDescriptionLabel.font = UITheme.Fonts.subTitleFont
        self.navigationDescriptionLabel.textColor = UITheme.Colors.subTitleColor
        self.sortButton.titleLabel?.font = UITheme.Fonts.subTitleFont
        self.sortButton.setTitleColor(UITheme.Colors.optionColor, for: .normal)
        self.sortButton.setTitleColor(UITheme.Colors.optionColor, for: .selected)
        self.sortButton.setTitleColor(UITheme.Colors.optionColor, for: .highlighted)
        self.filterButton.titleLabel?.font = UITheme.Fonts.subTitleFont
        self.filterButton.setTitleColor(UITheme.Colors.optionColor, for: .normal)
        self.filterButton.setTitleColor(UITheme.Colors.optionColor, for: .selected)
        self.filterButton.setTitleColor(UITheme.Colors.optionColor, for: .highlighted)
        self.sortButton.setTitle(StringConstant.sortOption, for: .normal)
        self.sortButton.setTitle(StringConstant.sortOption, for: .selected)
        self.sortButton.setTitle(StringConstant.sortOption, for: .highlighted)

        self.filterButton.setTitle(StringConstant.filterOption, for: .normal)
        self.filterButton.setTitle(StringConstant.filterOption, for: .selected)
        self.filterButton.setTitle(StringConstant.filterOption, for: .highlighted)

        self.tableView.register(UINib(nibName: ItineraryTableViewCell.nibName, bundle: nil),
                                forCellReuseIdentifier: ItineraryTableViewCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.reloadData()
        presenter?.getItineraries(cabinclass: "Economy",
                                  country: "UK",
                                  currency: "GBP",
                                  locale: "en-GB",
                                  locationSchema: "iata",
                                  originplace: "EDI",
                                  destinationplace: "LHR",
                                  outbounddate: "2019-02-25",
                                  inbounddate: "2019-02-26",
                                  adults: "1",
                                  children: "0",
                                  infants: "0")
    }

    @IBAction func sortTouchUp(_ sender: UIButton, forEvent event: UIEvent) {
        let touch = event.touches(for: sender)?.first
        let positionInWindow = (touch?.location(in: self.view))!
        let positionInButton = (touch?.location(in: self.sortButton))!
        let position = CGPoint(x: positionInWindow.x - positionInButton.x + 50.0/2,
                               y: positionInWindow.y - positionInButton.y + 30.0/2)
        self.presenter?.displaySortOptions(in: position)
    }
}

extension FlightLivePricesViewController: FlightLivePricesViewProtocol {
    func showItineraries(viewModel: [ItineraryViewModel], indexPaths: [IndexPath]) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.navigationDescriptionLabel.text = String(format: StringConstant.results, viewModel.count, viewModel.count)
            self.tableView.insertRows(at: indexPaths, with: .none)
        }
    }

    func showSortOptions(viewModel: [SortOptionViewModel], selectedIndex: Int, in point: CGPoint) {
        let vc = SortViewController(point: point, tableViewHeight: CGFloat(viewModel.count)*SortOptionTableViewCell.getHeight())
        vc.sortOptions = viewModel
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }

    func showLoading() {
        DispatchQueue.main.async {
            self.hud?.removeFromSuperview()
            self.hud = JGProgressHUD(style: .dark)
            self.hud?.isUserInteractionEnabled = false
            self.hud?.textLabel.text = StringConstant.loading
            self.hud?.show(in: self.view)
            self.navigationDescriptionLabel.text = StringConstant.loading
        }
    }

    func dismissLoading() {
        DispatchQueue.main.async {
            self.hud?.dismiss(animated: true)
        }
    }

    func stopDisplayResults() {

    }
}

extension FlightLivePricesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
extension FlightLivePricesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ItineraryTableViewCell.reuseIdentifier, for: indexPath) as? ItineraryTableViewCell {
            cell.setup(viewModel: (self.viewModel?[indexPath.row])!)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
}
