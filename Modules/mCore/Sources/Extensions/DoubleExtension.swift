//
//  DoubleExtension.swift
//  mCore
//
//  Created by Mateus Sousa on 15/12/20.
//

import Foundation

public extension Double {
    
    func convertInMoney() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pt-BR")
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
