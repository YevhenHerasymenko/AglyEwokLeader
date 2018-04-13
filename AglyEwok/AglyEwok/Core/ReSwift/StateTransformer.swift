//
//  Lens.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/2/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation

protocol StateTransformer {
  associatedtype ViewState
  static func transform(_ state: AppState) -> ViewState
  static func filter(old: ViewState, new: ViewState) -> Bool
}

extension StateTransformer {
  
  static func filter(old: ViewState, new: ViewState) -> Bool {
    return true
  }
}
