//
//  Request.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/6/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Alamofire

struct RequestInfo {
  var parameters: [String : Any]?
  var headers: [String : String]?
  var url: URLConvertible
  var method: Alamofire.HTTPMethod
  var responseHeader: Header
  var requestHeader: Header
  var encoding: String?
}

/// Class which contains all necessary information for creating request to server
struct Request<T> {
  
  /// REST method (GET, POST, PUT, DELETE)
  let method: Alamofire.HTTPMethod
  /// URL String
  let url: URLConvertible
  /// Parameters for request
  let parameters: [String : Any]?
  /// Type for parsing success response
  let result: T.Type
  let encoding: String?
  
  let headers: [String : String]?
  
  let responseHeader: Header
  let requestHeader: Header
  
  init(method: Alamofire.HTTPMethod = .get,
       url: URLConvertible,
       responseHeader: Header = .noHeader,
       requestHeader: Header = .noHeader,
       parameters: [String : Any]? = nil,
       headers: [String : String]? = nil,
       encoding: String? = nil) {
    self.method = method
    self.url = url
    self.parameters = parameters
    self.headers = headers
    self.encoding = encoding
    self.responseHeader = responseHeader
    self.requestHeader = requestHeader
    result = T.self
  }
  
  var requestInfo: RequestInfo {
    return RequestInfo(parameters: parameters,
                       headers: headers,
                       url: url,
                       method: method,
                       responseHeader: responseHeader,
                       requestHeader: requestHeader,
                       encoding: encoding)
  }
}

extension String: ParameterEncoding {
  
  public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var request = try urlRequest.asURLRequest()
    request.httpBody = data(using: .utf8, allowLossyConversion: false)
    return request
  }
  
}
