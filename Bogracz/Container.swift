//
//  Container.swift
//  Bogracz
//
//  Created by Pete Prokop on 05/11/2019.
//  Copyright © 2019 Pete Prokop. All rights reserved.
//

import Foundation

final public class Container {

    private var threadSafeDictionary = ThreadSafeDictionary<String, Any>()

    public func get<T>(_ type: T.Type) -> T {
        fatalError()
    }

    public func add<T>(_ dependency: T.Type) {

    }
    
}
