//
//  Extensions.swift
//  RobustaTask
//
//  Created by Menaim on 16/12/2021.
//

import Foundation
import UIKit


var imageCache = NSCache<AnyObject, AnyObject>() //8.6

extension UIImageView {
    func load(urlString : String) { // 8.1
        
        guard let url = URL(string: urlString)else { // 8.2
            return
        }
        
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage { //8.7
            self.image = image
            return
        }
        
        DispatchQueue.global().async { [weak self] in //8.3
            if let data = try? Data(contentsOf: url) { //8.4
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { //8.5
                        imageCache.setObject(image, forKey: urlString as NSString) //8.8
                        self?.image = image
                    }
                }
            }
        }
    }
}
