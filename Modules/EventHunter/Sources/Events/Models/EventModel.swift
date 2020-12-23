//
//  EventModel.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

struct EventModel: Decodable {
    let id: String
    let title: String
    let description: String
    let image: URL
    let price: Double
    let longitude: Double
    let latitude: Double
    @DateCustom var date: Date
}

@propertyWrapper
struct DateCustom: Decodable {
    var wrappedValue: Date
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let timeInterval = try value.decode(TimeInterval.self)
        wrappedValue = Date(timeIntervalSince1970: timeInterval)
    }
}
