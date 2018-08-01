//
//  Vector.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/14/18.
//  Copyright © 2018 grider. All rights reserved.
//

import Foundation
import CoreGraphics

public protocol VectorType: Equatable {

    static var zero: Self { get }

    var length: Double { get }

    static func +(lhs: Self, rhs: Self) -> Self

    static func +=(lhs: inout Self, rhs: Self)

    static func -(lhs: Self, rhs: Self) -> Self

    static func *(lhs: Self, rhs: Self) -> Self

    static func *(lhs: Double, rhs: Self) -> Self

}


public protocol VectorBase: Equatable {
    
    associatedtype VectorClass: VectorType
    
    init(vector: VectorClass)
    
    var vector: VectorClass { get }
}

public extension VectorBase {
    
    /// Returns an instance initialized using the zero vector.
    public static var zero: Self {
        return Self(vector: VectorClass.zero)
    }
}

public typealias Vector1 = Double

extension Vector1: VectorType {
    
    public init(value: Double) {
        self = value
    }
    
    public static var zero: Vector1 {
        return Vector1(0.0)
    }
    
    public var length: Double {
        get { return self }
    }
    
}

public struct Vector2: VectorType {
    
    public var x: Double

    public var y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    public static var zero: Vector2 {
        return Vector2(x: 0.0, y: 0.0)
    }
    
    public var length: Double {
        get { return sqrt(x*x + y*y) }
    }
    
    public static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
    }

    public static func +=(lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x-rhs.x, y: lhs.y-rhs.y)
    }

    public static func *(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs.x*rhs.x, y: lhs.y*rhs.y)
    }
    
    public static func *(lhs: Double, rhs: Vector2) -> Vector2 {
        return Vector2(x: lhs*rhs.x, y: lhs*rhs.y)
    }
    
    public static func ==(lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
    
}

extension Double: VectorBase {
    
    public init(vector: Vector1) {
        self.init(vector)
    }
    
    public var vector: Vector1 {
        return Vector1(self)
    }
    
}


extension CGPoint: VectorBase {
    
    /// Creates a new instance from a vector.
    public init(vector: Vector2) {
        self.init(
            x: vector.x,
            y: vector.y)
    }
    
    /// Returns the vector representation.
    public var vector: Vector2 {
        return Vector2(
            x: Double(x),
            y: Double(y))
    }
}

