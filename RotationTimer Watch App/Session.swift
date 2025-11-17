//
//  Session.swift
//  RotationTimer
//
//  Created by Mike on 2025-11-16.
//

import WatchKit
import SwiftUI

class Session: NSObject, WKExtendedRuntimeSessionDelegate {
    
    let session: WKExtendedRuntimeSession = WKExtendedRuntimeSession()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    func start() {
        session.start()
    }
    
    func stop() {
        session.invalidate()
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        
    }
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: (any Error)?) {}
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {}
    
}
