//
//  AboutCanadaViewModel.swift
//  AboutCanada
//
//  Created by Rahul Singh on 31/03/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import Alamofire

protocol AboutCanadaViewModelProtocol {
    func fetchTelstraData(completionHandler: @escaping (Bool, AlertMessage?) -> Void) 
}


class AboutCanadaViewModel: NSObject,AboutCanadaViewModelProtocol {
    
    private let apiManager = APIManager(sessionManager: SessionManager())
    
    func fetchTelstraData(completionHandler: @escaping (Bool, AlertMessage?) -> Void) {
        apiManager.callRequest(type: EndPointItem.telstra, handler: { (aboutCanada: AboutCanada?, message: AlertMessage?) in
            if aboutCanada != nil {
                completionHandler(true, nil)
            }else {
                completionHandler(false, message)
            }
        })
    }
    
}
