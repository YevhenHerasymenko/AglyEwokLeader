//
//  ViewIdentifier.swift
//  LogisticateIt
//
//  Created by YevhenHerasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import UIKit

protocol ViewIdentifier {
    static var identifier: String { get }
}

protocol ReusableView: ViewIdentifier {
    static var nib: UINib { get }
}

protocol ViewNib: ReusableView {
    associatedtype ViewType
    
    static var instanceFromNib: ViewType { get }
}
