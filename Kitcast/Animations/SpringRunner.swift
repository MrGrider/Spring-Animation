//
//  SpringRunner.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/14/18.
//  Copyright © 2018 grider. All rights reserved.
//

import Foundation

public struct SpringRunner<Vector>: AnimationRunner where Vector: VectorType {    

    public var springFactor: Double
    public var dampingFactor: Double
    private var threshold: Double

    private var animationState: AnimationState<Vector>

    public var target: Vector {
        didSet {
            guard target != oldValue else { return }
            
            animationState.state = .pending
            checkIfFinished()
        }
    }

    public var value: Vector {
        get { return animationState.value }
        set { animationState.value = newValue }
    }
    
    public var velocity: Vector {
        get { return animationState.velocity }
        set { animationState.velocity = newValue }
    }
    
    public var finished: Bool {
        return animationState.state == .finished
    }
    
    public init(target: Vector) {
        self.target = target
        springFactor = 180.0
        dampingFactor = 12.0
        threshold = 0.1
        animationState = AnimationState(value: target, velocity: Vector.zero)
    }

    private mutating func checkIfFinished() {
        guard animationState.state != .finished else { return }
        
        if abs(animationState.velocity.length) > threshold {
            animationState.state = .running
            return
        }
        
        if abs((animationState.value - target).length) > threshold {
            animationState.state = .running
            return
        }
        
        animationState.value = target
        animationState.velocity = Vector.zero
        animationState.state = .finished
        
    }
    
    public mutating func advance(by interval: Double) {
        guard animationState.state != .finished else { return }

        let springForce = -springFactor * (animationState.value - target)
        let dampingForce = dampingFactor * animationState.velocity
        
        let acceleration = springForce - dampingForce
        
        animationState.velocity += interval * acceleration
        animationState.value += interval * animationState.velocity

        checkIfFinished()
    }
}
