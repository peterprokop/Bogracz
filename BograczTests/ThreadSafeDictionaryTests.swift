//
//  ThreadSafeDictionaryTests.swift
//  BograczTests
//
//  Created by Pete Prokop on 05/11/2019.
//  Copyright © 2019 Pete Prokop. All rights reserved.
//

import XCTest
@testable import Bogracz

class ThreadSafeDictionaryTests: XCTestCase {

    func testConcurrentReadingAndWriting() {
        let tsd = ThreadSafeDictionary<String, Int>()
        // Note that if we change this to following:
        // var tsd = Dictionary<String, Int>()
        // Cycle in the end crashes almost instantly with `EXC_BAD_INSTRUCTION`

        let readingQueue = DispatchQueue(
            label: "ThreadSafeDictionaryTests.readingQueue",
            qos: .userInteractive,
            attributes: .concurrent
        )

        let writingQueue = DispatchQueue(
            label: "ThreadSafeDictionaryTests.writingQueue",
            qos: .userInteractive,
            attributes: .concurrent
        )

        // 2_000 seems to be small enough not to cause performance problems
        for i in 0 ..< 2_000 {
            let writeExpectation = expectation(description: "Write expectation")
            let readExpectation = expectation(description: "Read expectation")

            writingQueue.async {
                tsd["test"] = i
                writeExpectation.fulfill()
            }

            readingQueue.async {
                let value = tsd["test"]
                print(value as Any)
                readExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

}
