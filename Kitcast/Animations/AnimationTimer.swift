//
//  AnimationTimer.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/12/18.
//  Copyright © 2018 grider. All rights reserved.
//

import Foundation
import QuartzCore

public final class AnimationTimer {

    var paused: Bool {
        get { return displayLink.isPaused }
        set { displayLink.isPaused = newValue }
    }

    private var displayLink: CADisplayLink
    private let displayLinkTarget = DisplayLinkTarget()
    private let valueObserver: ValueObserver<CFTimeInterval>

    public init() {
        valueObserver = ValueObserver()
        displayLink = CADisplayLink(target: displayLinkTarget, selector: #selector(DisplayLinkTarget.timer(_:)))
        paused = true
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        displayLinkTarget.callback = { [unowned self] (interval) in
            self.valueObserver.post(value: interval)
        }
    }

    deinit {
        self.displayLink.invalidate()
    }

    public func observe(_ observer: @escaping (CFTimeInterval) -> Void) {
        return valueObserver.observe(observer)
    }
    
    internal final class DisplayLinkTarget {
        
        var callback: ((CFTimeInterval) -> Void)? = nil
        
        @objc dynamic func timer(_ displayLink: CADisplayLink) {
            let dt = displayLink.duration
            callback?(dt)
        }
        
    }

}
