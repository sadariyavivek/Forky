//
//  File.swift
//  
//
//  Created by Prakhar Pandey on 07/07/22.
//

import Foundation

/* Aysnc await backward compatible to iOS 13.0 */

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    
    @available(iOS 13.0, *)
    func data(from request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                
                continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
}
