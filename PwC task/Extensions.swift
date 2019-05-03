//
//  Extensions.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 03/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    static let PwC_Red = UIColor(red: 173/255, green: 27/255, blue: 4/255, alpha: 1)
    static let PwC_DarkOrange = UIColor(red: 192/255, green: 67/255, blue: 6/255, alpha: 1)
    static let PwC_Orange = UIColor(red: 217/255, green: 87/255, blue: 7/255, alpha: 1)
    static let PwC_DarkYellow = UIColor(red: 233/255, green: 140/255, blue: 22/255, alpha: 1)
    static let PwC_Yellow = UIColor(red: 244/255, green: 190/255, blue: 39/255, alpha: 1)
    static let error = UIColor(red: 100/255, green: 0/255, blue: 0/255, alpha: 1)
}

extension CGColor {
    static let PwC_Red = UIColor(red: 173/255, green: 27/255, blue: 4/255, alpha: 1).cgColor
    static let PwC_DarkOrange = UIColor(red: 192/255, green: 67/255, blue: 6/255, alpha: 1).cgColor
    static let PwC_Orange = UIColor(red: 217/255, green: 87/255, blue: 7/255, alpha: 1).cgColor
    static let PwC_DarkYellow = UIColor(red: 233/255, green: 140/255, blue: 22/255, alpha: 1).cgColor
    static let PwC_Yellow = UIColor(red: 244/255, green: 190/255, blue: 39/255, alpha: 1).cgColor
}

extension UIButton {
    func fancyButton() {
        self.backgroundColor = .PwC_Orange
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.setTitleColor(.white, for: .normal)
    }
}

extension UIView {
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [CGColor.PwC_Yellow, CGColor.PwC_Red]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setCornerRadiusAndShadow() {
        self.layer.cornerRadius = 15
        self.layer.shadowColor = .PwC_DarkOrange
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 0, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 5, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
