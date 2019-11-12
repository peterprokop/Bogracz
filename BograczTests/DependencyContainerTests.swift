//
//  DependencyContainerTests.swift
//  BograczTests
//
//  Created by Pete Prokop on 12/11/2019.
//  Copyright © 2019 Pete Prokop. All rights reserved.
//

import XCTest
@testable import Bogracz

let dummyMethodReturnValue = "I'm dummy method return value"

final class DependencyContainerTests: XCTestCase {

    func testAddingAndGetting() {
        let container = DependencyContainer()
        let dummyService: DummyServiceProviding = DummyService()

        container.add(DummyServiceProviding.self, instance: dummyService)

        XCTAssertEqual(
            container.get(DummyServiceProviding.self).dummyMethod(),
            dummyMethodReturnValue,
            "Container should return working instance"
        )

    }

}

protocol DummyServiceProviding {
    func dummyMethod() -> String
}

final class DummyService: DummyServiceProviding {
    func dummyMethod() -> String {
        return dummyMethodReturnValue
    }
}
