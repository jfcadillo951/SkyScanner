//
//  FlightLivePricesViewController.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

protocol FlightLivePricesViewProtocol {
    func showItineraries(viewModel: [ItineraryViewModel])
}
class FlightLivePricesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: [ItineraryViewModel]?
    var presenter: FlightsLivePricesPresenterProtocol?

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
        self.tableView.register(UINib(nibName: ItineraryTableViewCell.nibName, bundle: nil),
                                forCellReuseIdentifier: ItineraryTableViewCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
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


}

extension FlightLivePricesViewController: FlightLivePricesViewProtocol {
    func showItineraries(viewModel: [ItineraryViewModel]) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: ItineraryTableViewCell.reuseIdentifier, for: indexPath) as? ItineraryTableViewCell {
            cell.setup(viewModel: (self.viewModel?[indexPath.row])!)
            return cell
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel != nil) ? 1: 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
}
