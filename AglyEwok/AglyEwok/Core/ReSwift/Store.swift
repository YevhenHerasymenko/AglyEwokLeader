//
//  Store.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/7/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

let mainStore = Store<AppState>(
    reducer: AppState.appReducer,
    state: nil
)
