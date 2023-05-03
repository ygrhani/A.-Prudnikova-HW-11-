//
//  UIView + Extension.swift
//  A. Prudnikova (HW 11)
//
//  Created by Ann Prudnikova on 22.11.22.
//

import Foundation
import UIKit

extension UIView {
    func addBlur() {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffect = UIVisualEffectView(effect: blur)
        blurEffect.frame = self.bounds
        blurEffect.frame.origin.x = self.frame.origin.x
        blurEffect.frame.origin.y = self.frame.origin.y
        self.insertSubview(blurEffect, at: 4)
    }
    
    func removeBlur () {
        for sub in self.subviews {
            if sub is UIVisualEffectView {
                sub.removeFromSuperview()
            }
        }
    }
}
