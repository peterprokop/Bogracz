//
//  DependencyToken.swift
//  Bogracz
//
//  Created by Pete Prokop on 12/11/2019.
//  Copyright © 2019 Pete Prokop. All rights reserved.
//

import Foundation

struct DependencyToken {
    let type: Any.Type
    let configType: Any.Type?
}

extension DependencyToken: Equatable {
    static func == (lhs: DependencyToken, rhs: DependencyToken) -> Bool {
        return lhs.type == rhs.type
            && lhs.configType == rhs.configType
    }
}

extension DependencyToken: Hashable {
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(type).hash(into: &hasher)

        if let configType = configType {
            ObjectIdentifier(configType).hash(into: &hasher)
        }
    }
}
