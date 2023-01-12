//
//  File.swift
//  
//
//  Created by abc on 04/08/22.
//

import Foundation

/// Use this ``Header`` to set app level header for network layer
public struct Header {
    var deviceName: String
    var idString: String
    var appVersion: String
    var systemVersion: String
    var uuid: String
    var project: String
    var authorization: String?
    var language: String
    var deviceMake: String = "Apple"
    var platform: String = "iOS"
    var contentType: String = "application/json"
    
    /// Use this initlizer for creating instance of  ``Header``
    /// - Parameters:
    ///   - deviceName: Device name  => `iPhone 8`
    ///   - idString: Identifier => `"-1"`
    ///   - appVersion: App version  => `100`
    ///   - systemVersion: iOS version => `14.0`
    ///   - uuid: UUID string => `4b456dad-3edf-4ebb-adc3-31525cb38fc3`
    ///   - project: Project name => `Paham` or `Pluang`
    ///   - authorization: Authorization token   => `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ...`
    ///   - language: App language  => `English or Indonesian`
    ///   - deviceMake: Manufacturer => `"Apple" or "Google"`
    ///   - platform: App platform  => `iOS`
    ///   - contentType: `application/json`
    public init(deviceName: String, idString: String, appVersion: String, systemVersion: String, uuid: String, project: String, authorization: String?, language: String, deviceMake: String = "Apple", platform: String = "iOS", contentType: String = "application/json") {
        self.deviceName = deviceName
        self.idString = idString
        self.appVersion = appVersion
        self.systemVersion = systemVersion
        self.uuid = uuid
        self.project = project
        self.authorization = authorization
        self.language = language
        self.deviceName = deviceName
        self.platform = platform
        self.contentType = contentType
    }
}
