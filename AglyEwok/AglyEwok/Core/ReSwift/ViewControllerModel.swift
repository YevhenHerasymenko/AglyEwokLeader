//
//  ViewControllerModel.swift
//
//  Created by Oleksii Shvachenko.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation

protocol ViewControllerModel { }
protocol HasError {
    var error: String? { get }
}

protocol ViewControllerModelSupport {
    associatedtype ModelType: ViewControllerModel
    var model: ModelType? { get set }
    func render(_ model: ModelType)
}

extension ViewControllerModelSupport {
    func render(_ model: ModelType) {}
}
