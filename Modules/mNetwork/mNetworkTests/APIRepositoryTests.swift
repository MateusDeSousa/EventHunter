//
//  NetworkManagerTests.swift
//  mNetworkTests
//
//  Created by Mateus Sousa on 14/12/20.
//

import XCTest
@testable import mNetwork

class NetworkManagerTests: XCTestCase {
    
    func testFetchEvents() {
        let expactation = XCTestExpectation(description: "get list of events")
        
        let api = APIRepository()
        api.getEvents { (result) in
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
}
