//
//  UIView+Extensions.swift
//  MVVMDeneme
//
//  Created by Kadirhan Keles on 3.08.2023.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
