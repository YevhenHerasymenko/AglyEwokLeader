//
//  RequestOperation.swift
//
//  Created by Yevhen Herasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import UIKit
import Alamofire

class RequestOperation: BasicOperation {
  
  private struct HeaderField {
    static let token = "AuthenticateToken"
  }
  
  var parameters: [String : Any]?
  var headers: [String : String]
  var url: URLConvertible
  var method: Alamofire.HTTPMethod
  var error: NetworkError?
  var responseHeader: Header
  var encoding: String?
  
  let manager: Alamofire.SessionManager
  let reachability: NetworkReachabilityManager? = ReachabilityManager.shared.reachability
  
  init(request: RequestInfo) {
    method = request.method
    parameters = request.parameters
    url = request.url
    headers = request.headers ?? [:]

    if let requestHeaders = request.requestHeader.header {
      headers.merge(requestHeaders) { (current, _) in current }
    }
    if (request.url as? String)?.range(of: "http://bumagitest-cloudapp-net-uc16j7dxvm0w.runscope.net/") != nil {
      headers["Runscope-Request-Port"] = "12567"
    }
    
    encoding = request.encoding
    responseHeader = request.responseHeader
    
    let defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = defaultHeaders
    manager = Alamofire.SessionManager(configuration: configuration)
    super.init()
  }
  
  override func operation() {
    guard let reachability = reachability, reachability.isReachable else {
      error = NetworkError.noInternetConnection(nil)
      self.finish()
      return
    }
    manager
      .request(url, method: method,
               parameters: parameters,
               //encoding: encoding ?? JSONEncoding.default,
        headers: headers)
      .validate(statusCode: 200..<300)
      .responseJSON { [unowned self] response in
        defer {
          self.finish()
        }
        switch response.result {
        case .success(let result):
          self.checkResult(result as AnyObject)
          guard let header = response.response?.allHeaderFields else { return }
          self.responseHeader.parse(header: header)
        case .failure(let error):
          print(error.localizedDescription)
          guard let statusCode = response.response?.statusCode else {
            self.error = .unknown("Unexpected no status code!")
            return
          }
          do {
            guard let data = response.data,
              let dictionary = try JSONSerialization.jsonObject(with: data,
                                                                options: []) as? [String: AnyObject]
              else { return }
            self.error = NetworkError(statusCode: statusCode, error: dictionary)
          } catch {
            
            self.error = NetworkError(statusCode: statusCode)
          }
        }
    }
  }
  
  func checkResult(_ result: AnyObject) { }
}

class RequestSimpleOperation<T>: RequestOperation {
  var result: T?
  
  override func checkResult(_ result: AnyObject) {
    guard let result = result as? T else {
      self.error = .wrongFormat("Unexpected type")
      return
    }
    self.result = result
  }
  
}

class RequestObjectOperation: RequestOperation {
  var result: [String : AnyObject]?
  
  override func checkResult(_ result: AnyObject) {
    self.result = result as? [String: AnyObject] ?? [String: AnyObject]()
  }
}

class RequestArreyOperation: RequestOperation {
  var results: [[String : AnyObject]]?
  
  override func checkResult(_ result: AnyObject) {
    guard let resultDict = result as? [[String: AnyObject]] else {
      self.error = .wrongFormat("result not an array")
      return
    }
    self.results = resultDict
  }
}
