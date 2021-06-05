//
//  UIView-Extention.swift
//  BreakingBad
//


import UIKit

extension UIView {
    /// Add a new extenion for cornerRadius to any UIView
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
