//
//  ParseOperation.swift
//  Zerto_iOS
//
//  Created by Yevhen Herasymenko on 5/20/16.
//  Copyright © 2016 Yevhen Herasymenko. All rights reserved.
//

import ObjectMapper

struct JSONKey {
    static let errorCode = "ErrorCode"
    static let errorMessage = "ErrorMessage"
    static let result = "Result"
}

class ParseOperation<T: ImmutableMappable>: BasicOperation {
    
    var error: NetworkError?
    
    override func operation() {
        parse()
        finish()
    }
    
    func parse() { }
    
}

class ParseObjectOperation<T: ImmutableMappable>: ParseOperation<T> {
    var dictionary: [String : AnyObject]?
    var result: T?
    
    override func parse() {
        guard let dictionary = dictionary else {
            error = .wrongFormat("Empty dictionary for parsing!")
            return
        }
        do {
            let value = try Mapper<T>().map(JSON: dictionary)
            result = value
        } catch let error as MapError {
            self.error = .parsingError(error.description)
        } catch {
            fatalError("Can't parse model")
        }
    }
}

class ParseArrayOperation<T: ImmutableMappable>: ParseOperation<T> {
    
    var dictionaries: [[String : AnyObject]]?
    var results: [T]?
    
    override func parse() {
        guard let dictionaries = dictionaries else {
            error = .wrongFormat("No dictionaries for parsing!")
            return
        }
        do {
            let value = try Mapper<T>().mapArray(JSONArray: dictionaries)
            results = value
        } catch let error as MapError {
            self.error = .parsingError(error.description)
        } catch {
            fatalError("Can't parse model")
        }
    }
    
}
