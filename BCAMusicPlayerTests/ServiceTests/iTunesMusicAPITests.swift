//
//  iTunesMusicAPITests.swift
//  BCAMusicPlayerTests
//
//  Created by Ray on 08/07/23.
//

import XCTest
@testable import BCAMusicPlayer

class iTunesMusicAPITests: XCTestCase {

    var api: iTunesMusicAPI!

    override func setUp() {
        super.setUp()
        api = iTunesMusicAPI()
    }

    override func tearDown() {
        api = nil
        super.tearDown()
    }

    func testSearchMusic() {
        let expectation = XCTestExpectation(description: "Search music completion called")
        
        let searchTerm = "Shawn Mendes"
        
        api.searchMusic(withTerm: searchTerm) { result in
            switch result {
            case .success(let music):
                XCTAssertFalse(music.isEmpty, "Search result should not be empty")
            case .failure(let error):
                XCTFail("Search failed with error: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
