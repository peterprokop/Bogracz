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

    public func addStatic<T>(_ type: T.Type, instance: T) {
        let token = DependencyToken(type: type, configType: nil)
        threadSafeDictionary[token] = instance
    }

    public func addDynamic<T>(_ type: T.Type, block: @escaping (DependencyContainer) -> T) {
        let token = DependencyToken(type: type, configType: nil)
        threadSafeDictionary[token] = block
    }

    public func addDynamic<T, C>(_ type: T.Type, block: @escaping (DependencyContainer, C) -> T) {
        let token = DependencyToken(type: type, configType: C.self)
        threadSafeDictionary[token] = block
    }

}
