//
//  DateExtension.swift
//  mCore
//
//  Created by Mateus Sousa on 23/12/20.
//

import Foundation

public extension Date {
    
    func format(_ string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-BR")
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: self)
    }
}
