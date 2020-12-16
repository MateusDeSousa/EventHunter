//
//  IntExtension.swift
//  mCore
//
//  Created by Mateus Sousa on 15/12/20.
//

import Foundation

public extension Int {
    
    func convertInDate(format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale(identifier: "pt-BR")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
