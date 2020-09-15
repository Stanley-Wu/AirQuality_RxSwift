//
//  UIViewExtension.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/9/7.
//  Copyright © 2020 Stanley. All rights reserved.
//

import UIKit

extension UIView {
    func roundUpCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
  
    }
}
