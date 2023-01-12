//
//  Delegates.swift
//  
//
//  Created by Prakhar Pandey on 06/07/22.
//

import Foundation

/// Follow this delegate in AppDelegate -``NetworkLayerDelegate``
public protocol NetworkLayerDelegate: AnyObject {
    
    /// This method will be called when under maintenace is needed.
    func underMaintenance(_ data: [String: Any])
    
    /// This method will be called when user authentication fail so he/she need to verify again.
    func logout()
    
    /// This method will be use to block any user from accessing app.
    func userBlocked()
    
    /// This method will be use to show popup for force update.
    func forceUpdate()
    
    /// This method will be use to show popup for optional update.
    func optionalUpdate(_ data: [String: Any])
}

/// Follow this delegate in a class where you want to configure socket -``SocketServiceDelegate``
public protocol SocketServiceDelegate: AnyObject {
    
    /// This method notify you when your service is connected
    func connected()
    
    /// This method notify you when your service is disconnected
    func disconnected()
    
    /// This method notify you when your service throws an error
    /// - Parameter error: Here, error ``Error`` is what server is throwing
    func error(_ error: Error)
    
    /// This method notify you when your service start listening.
    /// - Parameter data: Here, data ``Data`` is what you are receiving from server.
    func listen(_ data: Data)
}
