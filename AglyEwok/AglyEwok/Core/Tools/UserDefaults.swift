//
//  UserDefaultService.swift
//  Profile
//
//  Created by YevhenHerasymenko on 1/27/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation

struct UserDefaultsService {
    
    enum Keys: String {
        case currentUser
        case server
    }
    
    static func save(_ value: Any, forKey key: UserDefaultsService.Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func register(_ value: Any, forKey key: UserDefaultsService.Keys) {
        UserDefaults.standard.register(defaults: [key.rawValue: value])
        UserDefaults.standard.synchronize()
    }

    static func value(for key: UserDefaultsService.Keys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    static func removeValue(for key: UserDefaultsService.Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}
