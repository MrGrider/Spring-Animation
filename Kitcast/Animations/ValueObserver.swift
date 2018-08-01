//
//  ValueObserver.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/14/18.
//  Copyright © 2018 grider. All rights reserved.
//

import Foundation

public final class ValueObserver<Value> {
    
    typealias ObserverBlock = (Value) -> Void
    
    private var observersList: [UUID:ObserverBlock] = [:]
    
    func post(value: Value) {
        for o in observersList.values {
            o(value)
        }
    }
    
    func observe(_ observerBlock: @escaping ObserverBlock) -> Void {
        let identifier = UUID()
        observersList[identifier] = observerBlock
    }
    
}
