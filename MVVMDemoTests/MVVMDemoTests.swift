//
//  MVVMDemoTests.swift
//  MVVMDemoTests
//
//  Created by Prashant on 15/03/18.
//

import XCTest
@testable import MVVMDemo

class MVVMDemoTests: XCTestCase {
    
    var  validViewModel:LoginViewModel!
    var inValidViewModel:LoginViewModel!
    
    override func setUp() {
        super.setUp()
        let user = User(userName: "prashant", password: "test12345678")
        
        validViewModel = LoginViewModel(user: user)
        inValidViewModel = LoginViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  
    func testLongUserName () {
        XCTAssertEqual(validViewModel.securedUserName, "******nt")
    }
   
    func testShortUserName () {
        validViewModel = LoginViewModel(user: User(userName: "test", password: "test123456"))
        XCTAssertEqual(validViewModel.userName, "test")
    }
    
    func testValidShortUserName () {
        inValidViewModel = LoginViewModel(user: User(userName: "pkt", password: "12345"))
        let validation = inValidViewModel.validate()
        
        if case .failed(let msg) = validation {
            XCTAssertEqual(msg, "User Name is not valid")
        } else {
            XCTAssert(false)
        }
    }
    
    func testValidateShortPassword () {
        inValidViewModel = LoginViewModel(user: User(userName: "prashant", password: "12345"))
        let validation = inValidViewModel.validate()
        
        if case .failed(let msg) = validation {
            XCTAssertEqual(msg, "Password should be 8 characters long")
        } else {
            XCTAssert(false)
        }
        
    }
    
    
}
