//
//  UICollectionViewCell+extension.swift
//  Forky
//
//  Created by Vivek Sadariya on 09/10/21.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }
}
