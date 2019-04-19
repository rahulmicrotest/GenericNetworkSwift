//
//  NetworkHelper.swift
//  DeltaTest
//
//  Created by Rahul Singh on 19/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import Alamofire


//MARK: ErrorObject
/*
 Error object is a class which we will use for parsing network errors.
 Key is the variable we use for localization of errors so we can show a message in proper language to the user.
 If we don’t have it localized, we use message variable.
 */
class ErrorObject: Codable {
    let message: String
    let key: String?
}


//MARK: EndPointType Protocol
/*
 EndpointType is a protocol which defines all values that we need to form URL request.
 When formed we will pass it to our API manager.
 Because HTTPMethod, HTTPHeaders, and ParameterEncoding are objects from Alamofire library, we need to import it.
 */
protocol EndPointType {
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
}


//MARK: EndPointItem Enum
/*
 EndpointItem is an enum object which implements EndpointType protocol.
 For each request on a server side, we will add new value to EndpointItem.

 */
enum EndPointItem {
    case telstra
    case delta
    case updateUser
}

/*
 We’ve chosen this implementation because it’s easy to use, change, and to add and remove values.
 
 */
extension EndPointItem: EndPointType {
    
    
    //baseURL
    var baseURL: String {
        switch APIManager.networkEnvironment {
        case .dev: return ""
        case .production: return ""
        case .stage: return ""
        }
    }
    
    //path
    var path: String {
        switch self {
        case .telstra:
            return Constants.telstraURLString
        case .delta:
            return Constants.deltaURLString
        case .updateUser:
            return "user/update"
        }
    }
    
    //httpMethod
    var httpMethod: HTTPMethod {
        switch self {
        case .updateUser:
            return .post
        default:
            return .get
        }
    }
    
    //httpHeaders
    var headers: HTTPHeaders? {
        switch self {
        case .updateUser:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest",
                    "x-access-token": "someToken"]
        default:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest"]
        }
    }
    
    //URL
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    //Encoding
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    //Version
    var version: String {
        return "/v0_1"
    }
}

//MARK: NetworkEnVironment
/*
 NetworkEnvironment is another enum object which will define a set of environments on a server side.
 */

enum NetworkEnvironment {
    case dev
    case production
    case stage
}


/*
 An important thing to mention is that the second argument of Result object needs to conform to Error protocol. We need to extend AlertMessage object.
 */

class AlertMessage: Error {
    
    // MARK: - Vars & Lets
    
    var title = ""
    var body = ""
    
    // MARK: - Intialization
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
}
