//
//  Container.swift
//  Bogracz
//
//  Created by Pete Prokop on 05/11/2019.
//  Copyright © 2019 Pete Prokop. All rights reserved.
//

import Foundation

final public class DependencyContainer {

    private var threadSafeDictionary = ThreadSafeDictionary<DependencyToken, Any>()

    public func get<T>(_ type: T.Type) -> T? {
        let token = DependencyToken(type: type, configType: nil)
        let instanceOrBlock = threadSafeDictionary[token]

        if let instance = instanceOrBlock as? T {
            return instance
        }

        if let block = instanceOrBlock as? (DependencyContainer) -> T {
            return block(self)
        }
        
        return nil
    }

    public func get<T, C>(_ type: T.Type, config: C) -> T? {
        let token = DependencyToken(type: type, configType: C.self)
        let block = threadSafeDictionary[token]

        if let block = block as? (DependencyContainer, C) -> T {
            return block(self, config)
        }

        return nil
    }

    /// Adds dependency statically
    ///
    /// - Parameters:
    ///   - type: type of the dependency
    ///   - instance: instance of the dependency
    public func add<T>(_ type: T.Type, instance: T) {
        let token = DependencyToken(type: type, configType: nil)
        threadSafeDictionary[token] = instance
    }

    /// Adds dependency dynamically (it will be created each time `get(...)` is called)
    ///
    /// - Parameters:
    ///   - type: type of the dependency
    ///   - block: block which creates the dependency
    public func add<T>(_ type: T.Type, block: @escaping (DependencyContainer) -> T) {
        let token = DependencyToken(type: type, configType: nil)
        threadSafeDictionary[token] = block
    }

    /// Adds dependency dynamically with configuration
    ///
    /// - Parameters:
    ///   - type: type of the dependency
    ///   - block: block which creates the dependency
    public func add<T, C>(_ type: T.Type, block: @escaping (DependencyContainer, C) -> T) {
        let token = DependencyToken(type: type, configType: C.self)
        threadSafeDictionary[token] = block
    }

}
