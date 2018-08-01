//
//  AnimationState.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/14/18.
//  Copyright © 2018 grider. All rights reserved.
//

import Foundation

public enum State {
    case pending
    case running
    case finished
}

public struct AnimationState <Vector> where Vector: VectorType {
    
    public var value: Vector
    public var velocity: Vector
    public var state: State = .pending
    
    public init (value: Vector, velocity: Vector) {
        self.value = value;
        self.velocity = velocity
    }
}
