//
//  CustomImageView.swift
//  SkyScanner
//
//  Created by Nisum on 2/3/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {

    var imageUrlString: String?

    func loadImageUsingUrlString(urlString: String) {

        imageUrlString = urlString

        let url = URL(string: urlString)!

        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url) { (data, respones, error) in
            if error != nil {
                return
            }

            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)

                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }

                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }.resume()
    }

}
