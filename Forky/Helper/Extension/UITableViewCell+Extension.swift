//
//  UITableViewCell+Extension.swift
//  Forky
//
//  Created by Vivek Sadariya on 04/10/21.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }
}
