//
//  APIRepository.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

class APIRepository {
    
    func getEvents(completion: @escaping (Result<[EventModel], Error>) -> Void) {
        let endPoint: String = "http://5f5a8f24d44d640016169133.mockapi.io/api/events"
        if let url = URL(string: endPoint) {
            do {
                let data = try Data(contentsOf: url)
                let listEvents = try JSONDecoder().decode([EventModel].self, from: data)
                completion(.success(listEvents))
            } catch {
                completion(.failure(error))
            }
        }else {
            let error = NSError()
            completion(.failure(error))
        }
    }
}
