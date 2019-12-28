//
//  Hashable.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/19/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

struct HashableType<T> : Hashable {
    
    static func == (lhs: HashableType, rhs: HashableType) -> Bool {
        return lhs.base == rhs.base
    }
    
    let base: T.Type
    
    init(_ base: T.Type) {
        self.base = base
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(base))
    }
    // Pre Swift 4.2:
    // var hashValue: Int { return ObjectIdentifier(base).hashValue }
}
