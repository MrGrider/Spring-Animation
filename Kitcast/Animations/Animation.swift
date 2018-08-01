//
//  Animation.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/12/18.
//  Copyright © 2018 grider. All rights reserved.
//

import Foundation

public class Animation<Vector, Runner> where Vector: VectorBase, Runner: AnimationRunner, Vector.VectorClass == Runner.VectorClass {
    
    private let animationTimer: AnimationTimer

    private let valueObserver = ValueObserver<Vector>()
    
    private var animationRunner: Runner {
        didSet {
            currentValue = Vector(vector: animationRunner.value)
            animationTimer.paused = animationRunner.finished
        }
    }
    
    private var currentValue: Vector {
        didSet {
            guard currentValue != oldValue else { return }
            valueObserver.post(value: currentValue)
        }
    }
    
    public init(runner: Runner, value: Vector) {
        animationRunner = runner
        currentValue = value
        animationTimer = AnimationTimer()
        animationTimer.observe { [unowned self] (duration) in
            self.animationRunner.advance(by: duration)
        }
    }
}

public extension Animation {
    public func bindObserver<T>(to view: T, keyPath: ReferenceWritableKeyPath<T, Vector>) {
        valueObserver.observe { (value) in
            view[keyPath: keyPath] = value
        }
    }
}

public extension Animation where Runner == SpringRunner<Vector.VectorClass> {

    public convenience init<T>(withView view: T, boundTo keyPath: ReferenceWritableKeyPath<T, Vector>) {
        let initialValue = view[keyPath: keyPath]
        let runner = SpringRunner(target: initialValue.vector)
        self.init(runner: runner, value: initialValue)
        bindObserver(to: view, keyPath: keyPath)
    }
    
    public func animate(to value: Vector) {
        animationRunner.target = value.vector
    }
    
    public func reset(to value: Vector) {
        animationRunner.target = value.vector
        animationRunner.value = value.vector
        animationRunner.velocity = Vector.zero.vector
    }

    public var springFactor: Double {
        get { return animationRunner.springFactor }
        set { animationRunner.springFactor = newValue }
    }
    
    public var dampingFactor: Double {
        get { return animationRunner.dampingFactor }
        set { animationRunner.dampingFactor = newValue }
    }

}

public typealias SpringAnimation<Vector> = Animation<Vector, SpringRunner<Vector.VectorClass>> where Vector: VectorBase
