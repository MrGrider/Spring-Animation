//
//  AnimationRunner.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/13/18.
//  Copyright © 2018 grider. All rights reserved.
//

import Foundation

public protocol AnimationRunner {
    
    associatedtype VectorClass: VectorType
    
    var value: VectorClass { get set }
    var velocity: VectorClass { get set }
    var finished: Bool { get }
    
    init(target: VectorClass)
    
    mutating func advance(by interval: Double)
    
}

