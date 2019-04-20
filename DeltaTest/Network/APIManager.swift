//
//  APIManager.swift
//  DeltaTest
//
//  Created by Rahul Singh on 18/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import  Alamofire

class APIManager {
        
    private let sessionManager: SessionManager
    
    //API manager will have static variable network environment which we use to form URL in EndointItemObject.
    static let networkEnvironment: NetworkEnvironment = .dev
    
    private static var sharedAPIManager: APIManager =  {
        let apiManager = APIManager(sessionManager: SessionManager())
        return apiManager
    }()

     init(sessionManager: SessionManager){
        self.sessionManager = sessionManager
    }
    
    class func shared() -> APIManager {
        return sharedAPIManager
    }
    
    private func parseApiError(data: Data?, errorObj: NSError?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            return AlertMessage(title: Constants.errorAlertTitle, body: error.key ?? error.message)
        }
        // For No Internet Connection Error
        if let error = errorObj {
            return AlertMessage(title: Constants.errorAlertTitle, body: error.localizedDescription)
        }
        // For Any Other error
        return AlertMessage(title: Constants.errorAlertTitle, body: Constants.genericErrorMessage)
    }
    
    
/*
     We are using generic argument T where T is Codable. T will inform APIManager about what kind of data we are fetching and what kind of object we want the manager to return. T can be any object or, an array of objects, which implements Decodable and Encodable protocols. After setting T, if needed, we can add request parameters.
     
     If the request is successful, we’ll get a predefined object. If not we will initialize the error object and display it using AlertMessage.
*/
    func callRequest<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseData { data in
                                        switch data.result {
                                        case .success(_):
                                            let decoder = JSONDecoder()
                                            
                                            if let responseData = data.result.value {
                                                let dataString = String(data: responseData , encoding: String.Encoding.isoLatin1)
                                                guard let modifiedData = dataString?.data(using: String.Encoding.utf8) else {
                                                    print("could not convert data to UTF-8 format")
                                                    return
                                                }
                                                
                                                let result = try! decoder.decode(T.self, from: modifiedData)
                                                handler(result, nil)
                                            }
                                            break
                                        case .failure(let error as NSError):
                                            handler(nil, self.parseApiError(data: data.data, errorObj: error))
                                            break
                                        }
        }
    }

    
/*
 This implementation has one problem. If the server responds with an empty object,
 the app will crash because you can’t decode it.
 Thus we need to implement one more method. Now the app won’t crash.
*/
    func callRequest(type: EndPointType, params: Parameters? = nil, handler: @escaping (()?, _ error: AlertMessage?)->()) {
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
                                        switch data.result {
                                        case .success(_):
                                            handler((), nil)
                                            break
                                        case .failure(let error as NSError):
                                            handler(nil, self.parseApiError(data: data.data, errorObj: error))
                                            break
                                        }
        }
    }

}
