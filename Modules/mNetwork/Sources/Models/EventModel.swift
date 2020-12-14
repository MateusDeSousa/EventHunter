//
//  EventModel.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

public struct EventModel: Decodable {
    let date: Int
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String
}
