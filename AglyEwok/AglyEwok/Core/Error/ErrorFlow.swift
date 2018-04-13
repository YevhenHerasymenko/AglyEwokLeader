//
//  ErrorState.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/2/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

struct ErrorFlow {
    
    struct State: StateType {
        var generalError: Error?
    }

}

extension ErrorFlow {
    struct Reducer {
        static func handleAction(action: Action, state: State?) -> State {
            var state = state ?? State(generalError: nil)
            switch action {
            case Actions.setError(let error):
                state.generalError = error
            default:
                state.generalError = nil
            }
            return state
        }
    }
}

extension ErrorFlow {

    enum Actions: Action {
        case setError(Error)
    }
    
}
