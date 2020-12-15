//
//  APIRepositoryTests.swift
//  mNetworkTests
//
//  Created by Mateus Sousa on 14/12/20.
//

import XCTest
@testable import mNetwork

class APIRepositoryTests: XCTestCase {
    
    func testGetAllEvents() {
        let expactation = XCTestExpectation(description: "get list of events")
        
        let api = APIRepository()
        api.getAllEvents { (result) in
            switch result {
            case .success(let events):
                XCTAssert(events.count > 0)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expactation.fulfill()
        }
        
        wait(for: [expactation], timeout: 4.0)
    }
    
    func testFetchEvents() {
        let expactation = XCTestExpectation(description: "get specific event")
        
        let api = APIRepository()
        api.getEvent(with: 1) { (result) in
            switch result {
            case .success(let event):
                XCTAssert(event.date == 1534784400)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expactation.fulfill()
        }
        
        wait(for: [expactation], timeout: 4.0)
    }
}
