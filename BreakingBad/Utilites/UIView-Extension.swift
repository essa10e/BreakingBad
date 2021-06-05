//
//  UIView-Extention.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/4/21.
//

import UIKit

extension UIView {
    /// Add a new extenion for cornerRadius to any UIView
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
