//
//  AppState.swift
//
//  Created by Oleksii Shvachenko.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

struct AppState: StateType {
  var error: ErrorFlow.State
}

extension AppState {
  static func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
      error: ErrorFlow.Reducer.handleAction(action: action, state: state?.error)
    )
  }
}
