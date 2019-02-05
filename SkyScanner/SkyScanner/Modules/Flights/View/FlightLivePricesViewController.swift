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
    func showLoading(viewModel: [ItineraryViewModel])
    func dismissLoading()
    func stopDisplayResults()
    func showError(title: String, message: String)
}

class FlightLivePricesViewController: UIViewController {

    @IBOutlet weak var skeletonTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    var skeletonViewModel: [ItineraryViewModel]?
    var viewModel: [ItineraryViewModel]?
    var presenter: FlightsLivePricesPresenterProtocol?
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var navigationSubTitleLabel: UILabel!
    @IBOutlet weak var navigationDescriptionLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    var hud: JGProgressHUD?
    var itineraryRequest: ItineraryRequest?
    

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
        self.navigationTitleLabel.text = "London to Madrid"
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
        self.skeletonTableView.register(UINib(nibName: ItineraryTableViewCell.nibName, bundle: nil),
                                forCellReuseIdentifier: ItineraryTableViewCell.reuseIdentifier)
        self.skeletonTableView.delegate = self
        self.skeletonTableView.dataSource = self
        self.skeletonTableView.separatorStyle = .none
        self.tableView.reloadData()
        let outboundate = Date.today().next(.monday)
        let inboundate = outboundate.next(.tuesday)
        self.navigationSubTitleLabel.text = DateHelper.sharedInstance.transform(date: outboundate, format: .human) + " - " + DateHelper.sharedInstance.transform(date: inboundate, format: .human)
        let outboundateString = DateHelper.sharedInstance.transform(date: outboundate, format: .simpleFormat)
        let inboundateString = DateHelper.sharedInstance.transform(date: inboundate, format: .simpleFormat)
        itineraryRequest = ItineraryRequest(cabinclass: "Economy",
                                            country: "UK",
                                            currency: "GBP",
                                            locale: "en-GB",
                                            locationSchema: "iata",
                                            originplace: "LHR",
                                            destinationplace: "MAD",
                                            outbounddate: outboundateString,
                                            inbounddate: inboundateString,
                                            adults: "1",
                                            children: "0",
                                            infants: "0")
        presenter?.getItineraries(cabinclass: itineraryRequest?.cabinclass ?? "",
                                  country: itineraryRequest?.country ?? "",
                                  currency: itineraryRequest?.currency ?? "",
                                  locale: itineraryRequest?.locale ?? "",
                                  locationSchema: itineraryRequest?.locationSchema ?? "",
                                  originplace: itineraryRequest?.originplace ?? "",
                                  destinationplace: itineraryRequest?.destinationplace ?? "",
                                  outbounddate: itineraryRequest?.outbounddate ?? "",
                                  inbounddate: itineraryRequest?.inbounddate ?? "",
                                  adults: itineraryRequest?.adults ?? "",
                                  children: itineraryRequest?.children ?? "",
                                  infants: itineraryRequest?.infants ?? "")
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
        let vc = SortViewController(point: point, tableViewHeight: CGFloat(viewModel.count)*SortOptionTableViewCell.getHeight(), sortOptions: viewModel, selectedSortOptionIndex: selectedIndex)
        vc.sortOptions = viewModel
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }

    func showLoading(viewModel: [ItineraryViewModel]) {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.hud?.removeFromSuperview()
            self.hud = JGProgressHUD(style: .dark)
            self.hud?.textLabel.text = StringConstant.loading
            self.hud?.show(in: self.view)
            self.navigationDescriptionLabel.text = StringConstant.loading
            self.skeletonViewModel = viewModel
            self.skeletonTableView.reloadData()
        }
    }

    func dismissLoading() {
        self.skeletonViewModel = []
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.skeletonTableView.reloadData()
            self.hud?.dismiss(animated: true)
        }
    }

    func stopDisplayResults() {

    }

    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: StringConstant.ok, style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(alertAction)
            self.tableView.isHidden = false
            self.present(alert, animated: true, completion: nil)
        }
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
        if self.tableView == tableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ItineraryTableViewCell.reuseIdentifier, for: indexPath) as? ItineraryTableViewCell {
                cell.setup(viewModel: (self.viewModel?[indexPath.row])!)
                cell.selectionStyle = .none
                return cell
            }
        } else if self.skeletonTableView == tableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ItineraryTableViewCell.reuseIdentifier, for: indexPath) as? ItineraryTableViewCell {
                cell.setup(viewModel: (self.skeletonViewModel?[indexPath.row])!)
                cell.selectionStyle = .none
                return cell
            }
        }

        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tableView == tableView {
            return viewModel?.count ?? 0
        } else if self.skeletonTableView == tableView {
            return self.skeletonViewModel?.count ?? 0
        }
        return 0
    }
}

extension FlightLivePricesViewController: SortViewControllerDelegate {
    func reloadFromSort(sortIndex: Int) {
        viewModel = []
        self.tableView.reloadData()
        presenter?.selectedSortOptionIndex = sortIndex
        presenter?.getItineraries(cabinclass: itineraryRequest?.cabinclass ?? "",
                                  country: itineraryRequest?.country ?? "",
                                  currency: itineraryRequest?.currency ?? "",
                                  locale: itineraryRequest?.locale ?? "",
                                  locationSchema: itineraryRequest?.locationSchema ?? "",
                                  originplace: itineraryRequest?.originplace ?? "",
                                  destinationplace: itineraryRequest?.destinationplace ?? "",
                                  outbounddate: itineraryRequest?.outbounddate ?? "",
                                  inbounddate: itineraryRequest?.inbounddate ?? "",
                                  adults: itineraryRequest?.adults ?? "",
                                  children: itineraryRequest?.children ?? "",
                                  infants: itineraryRequest?.infants ?? "")
    }
}
