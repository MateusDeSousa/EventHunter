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
        let expactation = XCTestExpectation(description: "Get list of events")
        
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
    
    func testGetEventWithId() {
        let expactation = XCTestExpectation(description: "Get specific event")
        
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
    
    func testCheckinEvent() {
        let expactation = XCTestExpectation(description: "Check in at an event")
        
        let api = APIRepository()
        api.checkinEvent(at: 1, name: "Mateus Sousa", email: "mateusdevsousa@gmail.com") { error in
            if let error = error { XCTFail(error.localizedDescription) }
            expactation.fulfill()
        }
        
        wait(for: [expactation], timeout: 4.0)
    }
}
