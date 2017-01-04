//
//  testGetCurrentTime.swift
//  roomate
//
//  Created by Aaron Levin on 12/11/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest
@testable import roomate

class testGetCurrentTime: XCTestCase {
    func testGetCurrentDateAndTime() {
        print("*******************")
        print(NSDate().getCurrentTimeAndDate())
        print("*******************")
    }
}
