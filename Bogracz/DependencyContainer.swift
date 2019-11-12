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

    public func get<T>(_ type: T.Type) -> T {
        let token = DependencyToken(type: type, configType: nil)
        return threadSafeDictionary[token] as! T
    }

    public func add<T>(_ type: T.Type, instance: T) {
        let token = DependencyToken(type: type, configType: nil)
        threadSafeDictionary[token] = instance
    }

}
