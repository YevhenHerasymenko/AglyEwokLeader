//
//  APIManager.swift
//
//  Created by Yevhen Herasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class APIManager: APIConformable {
    
    private let operationQueue = OperationQueue()
    
    func simpleRequest<T>(_ request: Request<T>, callback: @escaping ((_ result: Result<T>) -> Void)) {
        let requestOperation = RequestSimpleOperation<T>(request: request.requestInfo)
        requestOperation.completionBlock = {
            DispatchQueue.main.async(execute: {
                guard let result = requestOperation.result else {
                    guard let error = requestOperation.error else { fatalError("Request Operation without result") }
                    self.handleError(error, callback: callback)
                    return
                }
                callback(Result.success(result))
            })
        }
        operationQueue.addOperation(requestOperation)
    }
    
    func objectRequest<T: ImmutableMappable>(_ request: Request<T>,
                                             callback: @escaping ((_ result: Result<T>) -> Void)) {
        let requestOperation = RequestObjectOperation(request: request.requestInfo)
        let parseOperation = ParseObjectOperation<T>()
        let adapterOperation = BlockOperation(block: {
            guard let result = requestOperation.result else {
                parseOperation.cancel()
                if let error = requestOperation.error {
                    DispatchQueue.main.async {
                        self.handleError(error, callback: callback)
                    }
                }
                
                return
            }
            parseOperation.dictionary  = result
        })
        parseOperation.completionBlock = {
            DispatchQueue.main.async(execute: {
                guard let result = parseOperation.result else {
                    guard let error = parseOperation.error else { return }
                    self.handleError(error, callback: callback)
                    return
                }
                callback(Result.success(result))
            })
        }
        adapterOperation.addDependency(requestOperation)
        parseOperation.addDependency(adapterOperation)
        operationQueue.addOperation(requestOperation)
        operationQueue.addOperation(adapterOperation)
        operationQueue.addOperation(parseOperation)
    }
    
    func arrayRequest<T: ImmutableMappable>(_ request: Request<T>,
                                            callback: @escaping ((_ result: Result<[T]>) -> Void)) {
        let requestOperation = RequestArreyOperation(request: request.requestInfo)
        let parseOperation = ParseArrayOperation<T>()
        let adapterOperation = BlockOperation(block: {
            guard let result = requestOperation.results else {
                if let error = requestOperation.error {
                    DispatchQueue.main.async {
                        self.handleError(error, callback: callback)
                    }
                }
                parseOperation.cancel()
                return
            }
            parseOperation.dictionaries  = result
        })
        parseOperation.completionBlock = {
            DispatchQueue.main.async(execute: {
                guard let result = parseOperation.results else {
                    guard let error = parseOperation.error else { return }
                    self.handleError(error, callback: callback)
                    return
                }
                callback(Result.success(result))
            })
        }
        adapterOperation.addDependency(requestOperation)
        parseOperation.addDependency(adapterOperation)
        operationQueue.addOperation(requestOperation)
        operationQueue.addOperation(adapterOperation)
        operationQueue.addOperation(parseOperation)
    }
    
    func cancel() {
        operationQueue.cancelAllOperations()
    }
    
    private func handleError<Type>(_ error: NetworkError,
                                   callback: @escaping ((_ result: Result<Type>) -> Void)) {
        //default handler
        
        callback(Result.failure(error))
    }
    
    deinit {
        print("delete")
    }
}
