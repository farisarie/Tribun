//
//  DateConverter.swift
//  Tribun
//
//  Created by yoga arie on 16/10/23.
//

import Foundation

final class DateConverter {
    static func convertDate(_ date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let originalDate = dateFormatter.date(from: date) { // Parsing to date object to recognize the format
            dateFormatter.timeZone = TimeZone.current
            
            dateFormatter.dateFormat = "EEEE, dd MMM yyyy, h:mm a"
            
            dateFormatter.locale = Locale(identifier: "id_ID")
            
            let convertedDataString = dateFormatter.string(from: originalDate)
            return convertedDataString
        }
        return date
        
    }
}
