//
//  File.swift
//  
//
//  Created by Prakhar Pandey on 11/07/22.
//

import Foundation

/// Stores complete API response
struct Response {
    private(set) var data: Data
    private(set) var request: URLRequest
    private(set) var response: URLResponse
    
    internal init(_ data: Data, _ request: URLRequest, _ response: URLResponse) {
        self.data = data
        self.request = request
        self.response = response
    }
}
