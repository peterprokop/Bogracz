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

    func testStaticAddingAndGetting() {
        let container = DependencyContainer()
        let dummyService: DummyServiceProviding = DummyService()

        container.addStatic(DummyServiceProviding.self, instance: dummyService)

        XCTAssertEqual(
            container.get(DummyServiceProviding.self)?.dummyMethod(),
            dummyMethodReturnValue,
            "Container should return working instance"
        )
    }

    func testDynamicAddingAndGetting() {
        let container = DependencyContainer()

        container.addDynamic(DummyServiceProviding.self, block: { _ in
            return DummyService()
        })

        XCTAssertEqual(
            container.get(DummyServiceProviding.self)?.dummyMethod(),
            dummyMethodReturnValue,
            "Container should return working instance"
        )
    }

    func testDynamicAddingAndGettingWithConfig() {
        let container = DependencyContainer()
        let config = DummyServiceConfig(dummyMethodReturnValue: "test")

        container.addDynamic(DummyServiceProviding.self, block: { (r, config: DummyServiceConfig) in
            return DummyServiceWithConfig(config: config)
        })

        XCTAssertEqual(
            container.get(DummyServiceProviding.self, config: config)?.dummyMethod(),
            config.dummyMethodReturnValue,
            "Container should return working instance"
        )

        XCTAssertNil(
            container.get(DummyServiceProviding.self),
            "Container should return nil without config"
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

final class DummyServiceWithConfig: DummyServiceProviding {

    let config: DummyServiceConfig

    init(config: DummyServiceConfig) {
        self.config = config
    }

    func dummyMethod() -> String {
        return config.dummyMethodReturnValue
    }
}

struct DummyServiceConfig {
    let dummyMethodReturnValue: String
}
