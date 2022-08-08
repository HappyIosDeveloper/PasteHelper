//
//  Extensions.swift
//  PasteHelperDemo
//
//  Created by Ahmadreza on 8/5/22.
//

import UIKit

extension UIView {
    
    enum CornerRadius: CGFloat {
        case none = 0
        case large = 15
        case regular = 10
        case small = 5
        case round = -1
        case superLarge = 25
        case massiveLarge = 60
    }

    var allSubViews: [UIView] {
        var array = [self.subviews].flatMap {$0}
        array.forEach { array.append(contentsOf: $0.allSubViews) }
        return array
    }
    
    func dropNormalShadow(opacity:Float = 0.05) {
        DispatchQueue.main.async { [weak self] in
            self?.layer.masksToBounds = false
            self?.layer.shadowColor = UIColor.gray.cgColor
            self?.layer.shadowOpacity = opacity
            self?.layer.shadowOffset = CGSize(width: 0, height: 0)
            self?.layer.shadowRadius = 8
        }
    }
    
    func roundUp(_ value: CornerRadius) {
        DispatchQueue.main.async { [weak self] in
            if value == .round {
                self?.layer.cornerRadius = (self?.bounds.height ?? 2) / 2
            } else {
                self?.layer.cornerRadius = value.rawValue
            }
            self?.layer.masksToBounds = true
        }
    }
    
    func dropShadowAndCornerRadious(_ value: CornerRadius, shadowOpacity: Float = 0.1) {
        roundUp(value)
        dropNormalShadow(opacity: shadowOpacity)
    }
}
