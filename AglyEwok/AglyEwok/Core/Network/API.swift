//
//  API.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/6/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ObjectMapper

/**
 Result for API request
 
 - Failure: error
 - Success: result which was mapped into some model object/objects
 */
enum Result<T> {
    case failure(NetworkError)
    case success(T)
}

protocol APIConformable {
    init()
    
    func simpleRequest<T>(_ request: Request<T>, callback: @escaping ((_ result: Result<T>) -> Void))
    
    func objectRequest<T: ImmutableMappable>(_ request: Request<T>,
                                             callback: @escaping ((_ result: Result<T>) -> Void))
    func arrayRequest<T: ImmutableMappable>(_ request: Request<T>,
                                            callback: @escaping ((_ result: Result<[T]>) -> Void))
    func cancel()
}
