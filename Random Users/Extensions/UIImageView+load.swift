//
//  UIImageView+load.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 29/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

extension UIImageView {
    /**
     Load image from URL asynchronously
     - Parameter url: Image URL
     */
    func load(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
