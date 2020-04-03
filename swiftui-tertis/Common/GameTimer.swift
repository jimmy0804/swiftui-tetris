//
//  GameTimer.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 28/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

protocol GameTimerDelegate: AnyObject {
    func timerFired()
}

public final class GameTimer {
    
    static let framesPerSecond = 30
    
    private lazy var timer: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(handleFrame))
        displayLink.preferredFramesPerSecond = Self.framesPerSecond
        displayLink.isPaused = true
        displayLink.add(to: RunLoop.current, forMode: .default)
        return displayLink
    }()
    
    private var counter = 0

    weak var delegate: GameTimerDelegate?
    
    init(delegate: GameTimerDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        timer.invalidate()
    }
    
    public func start() {
        timer.isPaused = false
    }
    
    public func stop() {
        timer.isPaused = true
    }
    
    @objc private func handleFrame() {
        counter += 1
        
        if counter >= Self.framesPerSecond {
            delegate?.timerFired()
            counter = 0
        }
    }
}
