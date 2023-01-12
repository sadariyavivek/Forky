//
//  MockConfiguration.swift
//  
//
//  Created by Prakhar Pandey on 04/07/22.
//

import Foundation

/// MockConfiguration: Use it for mock api request
public struct MockConfiguration: Configuration {
    private(set) var jsonFileName: String
    private(set) var bundle: Bundle
    
    /// - Parameters:
    ///   - jsonFileName: Local JSON file name with extension `.json`
    ///   - bundle: App main  bundle or any bundle
    public init(jsonFileName: String, _ bundle: Bundle = .main) {
        self.jsonFileName = jsonFileName
        self.bundle = bundle
    }
}
