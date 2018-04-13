//
//  Reachability.swift
//
//  Created by Yevhen Herasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import Foundation
import Alamofire

final class ReachabilityManager {
    
    static let shared = ReachabilityManager()
    
    var reachability = NetworkReachabilityManager(host: "www.apple.com")
    
    func startChecking() {
        guard let reachability = reachability else { return }
        reachability.startListening()
    }
    
    func stopChecking() {
        guard let reachability = reachability else { return }
        reachability.stopListening()
    }
}
