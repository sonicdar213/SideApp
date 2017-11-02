//
//  Side.swift
//  Side
//
//  Created by Truong Son Nguyen on 10/26/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import XCTest
import EarlGrey
class Side: XCTestCase {
    

    func testBasicSelectionAndAction() {
        // Select and tap the button with Accessibility ID "Sign".
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Sign"))
            .perform(grey_tap())
    }
    func testExample() {
        EarlGrey.select(elementWithMatcher: grey_keyWindow())
            .assert(grey_sufficientlyVisible())
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testBasicSelectionAndAssert() {
        // Select the button with Accessibility ID "clickMe" and assert it's visible.
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Sign"))
            .assert(with: grey_sufficientlyVisible())
    }
    func testBasicSelectionActionAssert() {
        // Select and tap the button with Accessibility ID "clickMe", then assert it's visible.
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Member"))
            .perform(grey_tap())
            .assert(with: grey_sufficientlyVisible())
    }
    
    
}
