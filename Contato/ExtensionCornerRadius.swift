//
//  ExtensionCornerRadius.swift
//  Contato
//
//  Created by Nando on 22/03/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set{
             layer.cornerRadius = newValue
             clipsToBounds = true
        }
    }
}
