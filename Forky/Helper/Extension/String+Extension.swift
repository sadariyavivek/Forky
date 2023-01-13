//
//  String+Extension.swift
//  Forky
//
//  Created by Irfan Tai on 23/10/1944 Saka.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func convertDateFormat(withFormat format: String = "yyyy-MM-dd") -> String? {

         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
        // dateFormatter.timeZone = TimeZone(name: "UTC")
        if let date = dateFormatter.date(from: self) {
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.dateFormat = "dd MMM"
            return convertDateFormatter.string(from: date)
        }
        return nil
    }
}
