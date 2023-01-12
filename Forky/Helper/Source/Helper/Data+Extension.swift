//
//  Data+Extension.swift
//  
//
//  Created by Prakhar Pandey on 07/07/22.
//

import Foundation

@available(iOS 13.0, *)
public extension Data {
    /// Returns a value of the type you specify, decoded from a JSON object.
    /// - Parameter type: The type of the value to decode from the supplied JSON object
    /// - Returns: A value of the specified type, if the decoder can parse the data.
    func decode<T: Decodable>(_ type: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(type, from: self)
        } catch {
            Logger.log(LogParam(error: error, type: .jsonDecoder))
            return nil
        }
    }
}
