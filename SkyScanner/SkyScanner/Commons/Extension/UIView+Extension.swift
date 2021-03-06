//
//  UIView+Extension.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

extension UIView {

    // allows use custom bundle in modularization
    @objc open func setupView(bundle: Bundle? = nil) {
        let view = viewFromNibForClass(bundle: bundle)
        view.frame = bounds
        addSubview(view)
    }

    private func viewFromNibForClass(bundle: Bundle?) -> UIView {
        let bundleFinal = bundle ?? Bundle(for: type(of: self))
        let view = bundleFinal.loadNibNamed(String(describing: type(of: self)),
                                            owner: self,
                                            options: nil)?.first as! UIView
        return view
    }

    public func addAllRoundBorder(cornerRadius: CGFloat = 5) {
        self.layer.cornerRadius = cornerRadius
    }

    //use it like: yourView.addRoundBorder(cornerRadius: 10, corners: [.topLeft, .bottomLeft])
    public func addRoundBorder(cornerRadius: CGFloat = 5, corners: UIRectCorner = [.topLeft, .bottomLeft, .topRight, .topLeft]) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
