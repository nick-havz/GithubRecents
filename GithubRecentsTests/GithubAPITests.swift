//
//  GithubAPITests.swift
//  GithubRecentsTests
//
//  Created by Nick Hawryluk on 8/21/21.
//

import XCTest
@testable import GithubRecents

class GithubAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_getCommitsJSONParsing(){
        if let exampleJSONPath = Bundle.main.path(forResource: "github_api_sample", ofType: "json"){
            do{
                XCTAssertNoThrow(try Data(contentsOf: URL(string: exampleJSONPath)!))
                let jsonString = try Data(contentsOf: URL(string: exampleJSONPath)!)
                XCTAssertNoThrow(try JSONDecoder().decode([Commit].self, from: jsonString))
                let sampleCommits = try JSONDecoder().decode([Commit].self, from: jsonString)
                XCTAssert(sampleCommits.count > 0)
            }catch{
                
            }
        }
    }

}
