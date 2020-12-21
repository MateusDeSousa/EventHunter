//
//  EventModel.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

struct EventModel: Decodable {
    let date: Int
    let description: String
    let image: URL
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String
}
