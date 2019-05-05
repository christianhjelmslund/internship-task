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
    static let dark = UIColor(red: 50/255, green: 64/255, blue: 88/255, alpha: 1)
    static let error = UIColor(red: 100/255, green: 0/255, blue: 0/255, alpha: 1)
}

extension CGColor {
    static let PwC_Red = UIColor(red: 173/255, green: 27/255, blue: 4/255, alpha: 1).cgColor
    static let PwC_DarkOrange = UIColor(red: 192/255, green: 67/255, blue: 6/255, alpha: 1).cgColor
    static let PwC_Orange = UIColor(red: 217/255, green: 87/255, blue: 7/255, alpha: 1).cgColor
    static let PwC_DarkYellow = UIColor(red: 233/255, green: 140/255, blue: 22/255, alpha: 1).cgColor
    static let PwC_Yellow = UIColor(red: 244/255, green: 190/255, blue: 39/255, alpha: 1).cgColor
    static let dark = UIColor(red: 50/255, green: 64/255, blue: 88/255, alpha: 1).cgColor
    static let very_dark = UIColor(red: 5/255, green: 13/255, blue: 29/255, alpha: 1).cgColor
    
}

extension UIButton {
    func fancyButton() {
        self.setDarkGradient()
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.setTitleColor(.white, for: .normal)
    }
}

extension UIView {
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [CGColor.PwC_Yellow, CGColor.PwC_DarkOrange]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0 ]
        layer.add(animation, forKey: "shake")
    }

    
    func setDarkGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [CGColor.dark, CGColor.very_dark]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    
    func setCornerRadiusAndShadow() {
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
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

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .dark
        titleLabel.font = UIFont(name: "SF-Compact-Text-Regular", size: 26)
        messageLabel.textColor = .dark
        messageLabel.font = UIFont(name: "SF-Compact-Text-Regular", size: 22)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

