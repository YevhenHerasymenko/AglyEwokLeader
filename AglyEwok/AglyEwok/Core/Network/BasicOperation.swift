//
//  BasicOperation.swift
//
//  Created by Yevhen Herasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import UIKit

class BasicOperation: Operation {
    
    fileprivate var _executing = false
    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    fileprivate var _finished = false
    override var isFinished: Bool {
        get {
            return _finished
        }
        set {
            if _finished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    override func start() {
        guard !isCancelled  else {
            isFinished = true
            return
        }
        isExecuting = true
        isFinished = false
        operation()
    }
    
    func operation() { }
    
    func finish() {
        isExecuting = false
        isFinished = true
    }

}
