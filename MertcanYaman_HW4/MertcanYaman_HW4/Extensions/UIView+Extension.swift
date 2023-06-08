//
//  UIView+Extension.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
