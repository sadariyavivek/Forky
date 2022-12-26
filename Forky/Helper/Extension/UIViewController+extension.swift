//
//  UIViewController+extension.swift
//  Forky
//
//  Created by Vivek Patel on 17/09/22.
//

import Foundation

import UIKit
import AVFoundation

extension UIViewController {
    
    class func instantiateFromStoryboard(_ name: String = "Main") -> Self {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T else {
            fatalError("No storyboard with name..... \(String(describing: self))")
        }
        return controller
    }
//    class func instantiateFromStoryboard(_ name: String = "Main") -> Self
//    {
//        return instantiateFromStoryboardHelper(name)
//    }
//
//    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T
//    {
//        let storyboard = UIStoryboard(name: name, bundle: nil)
//        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T else {
//            fatalError("No storyboard with name..... \(String(describing: self))")
//    }
}
