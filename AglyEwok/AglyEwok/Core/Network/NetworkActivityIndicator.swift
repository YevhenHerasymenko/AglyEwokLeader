//
//  NetworkActivityIndicator.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/1/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import AlamofireNetworkActivityIndicator

final class NetworkActivityIndicator {
    static func setup() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.completionDelay = 0.2
        NetworkActivityIndicatorManager.shared.startDelay = 0.1
    }
}
