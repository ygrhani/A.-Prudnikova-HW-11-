//
//  UITableView + extension.swift
//  A. Prudnikova (HW 11)
//
//  Created by Ann Prudnikova on 3.11.22.
//

import Foundation
import UIKit

extension UITextField {
    func setShades(textField: UITextField) {
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 7.5
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize.zero
    }
    
    
}
