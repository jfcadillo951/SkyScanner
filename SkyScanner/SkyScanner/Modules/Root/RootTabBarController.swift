//
//  RootViewController.swift
//  SkyScanner
//
//  Created by Nisum on 2/4/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    var tabBarViewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addViewController(CustomNavigationController(rootViewController: ExploreViewController()), image: #imageLiteral(resourceName: "iconExplore"), selectedImage: #imageLiteral(resourceName: "iconExplore"))
        addViewController(CustomNavigationController(rootViewController: FlightLivePricesViewController()), image: #imageLiteral(resourceName: "iconSearch"), selectedImage: #imageLiteral(resourceName: "iconSearch"))
        addViewController(CustomNavigationController(rootViewController: UserViewController()), image: #imageLiteral(resourceName: "iconProfile"), selectedImage: #imageLiteral(resourceName: "iconProfile"))
        self.viewControllers = tabBarViewControllers
        self.selectedIndex = 1
    }

    func addViewController(_ viewController: UIViewController, image: UIImage?, selectedImage: UIImage?) {
        viewController.title = title
        viewController.tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        viewController.tabBarItem.setTitleTextAttributes(
            [
                NSAttributedString.Key.strokeColor: UITheme.Colors.subTitleColor
            ], for: .normal)
        viewController.tabBarItem.setTitleTextAttributes(
            [
                NSAttributedString.Key.strokeColor: UITheme.Colors.optionColor
            ], for: .selected)
        tabBarViewControllers.append(viewController)
    }

}
