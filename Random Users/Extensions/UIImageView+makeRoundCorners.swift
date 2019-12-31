//
//  UIImageView+makeRoundCorners.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 31/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

extension UIImageView {
    /**
    Create round corners for image
    - Parameter byRadius: Corner radius
    */
    func makeRoundCorners(byRadius rad: CGFloat) {
        self.layer.cornerRadius = rad
        self.clipsToBounds = true
    }
}
