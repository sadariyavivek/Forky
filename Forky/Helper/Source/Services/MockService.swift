//
//  MockService.swift
//  
//
//  Created by Prakhar Pandey on 04/07/22.
//

import Foundation

    /// This is the mock service to mock any network request.
@available(iOS 13.0, *)
final class MockService {
    
    static let `default` = MockService()
    
    private init() {}
    
    func process(_ configuration: MockConfiguration) async -> Result<Data, Error> {
        
        guard let file = configuration.bundle.url(forResource: configuration.jsonFileName, withExtension: "json") else {
            let logParam = LogParam(error: URLServiceError.fileNotFound as NSError, type: .mock)
            Logger.log(logParam)
            return .failure(URLServiceError.fileNotFound)
        }
        
        do {
            let data = try Data(contentsOf: file)
            Logger.log(LogParam(data: data, type: .mock))
            return .success(data)
        } catch (let error as NSError) {
            Logger.log(LogParam(error: error, type: .mock))
            return .failure(error)
        }
    }
}
