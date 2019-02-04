//
//  PopUpDetailViewController.swift
//  SkyScanner
//
//  Created by Nisum on 2/3/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class PopUpDetailViewController: UIViewController {

    @IBOutlet weak var containerTableView: UIView!
    @IBOutlet weak var containerDetailView: UIView!
    @IBOutlet weak var arrorImageView: UIImageView!
    @IBOutlet weak var arrowIconWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowIconHeightConstraint: NSLayoutConstraint!
    @IBOutlet public weak var arrowIconViewTopConstraint: NSLayoutConstraint!
    @IBOutlet public weak var arrowIconLeadConstraint: NSLayoutConstraint!
    @IBOutlet public weak var tableView: UITableView!
    @IBOutlet weak var containerDetailViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerDetailViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerDetailViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!

    var point: CGPoint = .zero
    var tableViewHeight: CGFloat = 0.0
    var initialContainerDetailViewWidth: CGFloat = 0.0
    var initialContainerDetailViewHeight: CGFloat = 0.0
    var initialContainerDetailViewTrail: CGFloat = 0.0

    init() {
        super.init(nibName: "PopUpDetailViewController", bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupUI() {
        self.view.backgroundColor = .clear
        self.containerDetailView.clipsToBounds = true
        self.containerTableView.clipsToBounds = true
        self.containerTableView.layer.cornerRadius = 6.0
        self.tableView.bounces = false
        self.tableView.alpha = 0.0
        self.shadowView.alpha = 0.0
        self.initialContainerDetailViewWidth = self.containerDetailViewWidthConstraint.constant
        self.initialContainerDetailViewHeight = self.containerDetailViewHeightConstraint.constant
        self.initialContainerDetailViewTrail = self.containerDetailViewTrailingConstraint.constant
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func prepareAnimation(point: CGPoint, tableViewHeight: CGFloat) {
        self.point = point
        self.arrowIconLeadConstraint.constant = self.point.x - self.arrowIconWidthConstraint.constant / 2
        self.arrowIconViewTopConstraint.constant = self.point.y + 6
        self.tableViewHeight = tableViewHeight
    }

    func doAnimation() {
        self.view.layoutIfNeeded()
        DispatchQueue.main.async {
            self.containerDetailView.alpha = 0.2
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.shadowView.alpha = 0.7
            }, completion: { (_) in

            })
            UIView.animate(withDuration: 0.2, animations: {
                self.containerDetailViewWidthConstraint.constant = UIScreen.main.bounds.size.width
                self.containerDetailViewHeightConstraint.constant = 7 + self.tableViewHeight
                self.containerDetailViewTrailingConstraint.constant = 0
                self.containerDetailView.alpha = 1.0
                self.tableView.alpha = 1.0
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                if completed {
                    self.displayData()
                }
            })
        }
    }

    func doDismissAnimation(completition: @escaping () -> Void) {

        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.tableView.alpha = 0.0
        }, completion: { (_) in
            UIView.animate(withDuration: 0.2, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.shadowView.alpha = 0.0
            }, completion: { (_) in
                completition()
            })

            UIView.animate(withDuration: 0.2, animations: {
                self.containerDetailViewTrailingConstraint.constant = self.initialContainerDetailViewTrail
                self.containerDetailViewWidthConstraint.constant = self.initialContainerDetailViewWidth
                self.containerDetailViewHeightConstraint.constant = self.initialContainerDetailViewHeight
                self.containerDetailView.alpha = 0.0
                self.view.layoutIfNeeded()
            })
        })

    }

    func displayData() {

    }
    
    @IBAction func dismissTouchUp(_ sender: Any) {
        self.dismissPopUp()
    }

    func dismissPopUp() {
        self.doDismissAnimation {
            self.dismiss(animated: false, completion: nil)
        }
    }

}

extension PopUpDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PopUpDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
