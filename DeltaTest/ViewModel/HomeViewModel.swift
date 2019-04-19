//
//  HomeViewModel.swift
//  DeltaTest
//
//  Created by Rahul Singh on 18/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import Alamofire

protocol HomeViewModelProtocol {
    func fetchHomeData(completionHandler: @escaping (Bool, AlertMessage?) -> Void)
}

class HomeViewModel: HomeViewModelProtocol {
    
    
    private let apiManager = APIManager(sessionManager: SessionManager())

    
    func fetchHomeData(completionHandler: @escaping (Bool, AlertMessage?) -> Void) {
        guard let endPointURL = URL(string: Constants.deltaURLString) else {
            print("Error unwrapping URL "); return }

        func getDeltaData() {
            apiManager.callRequest(type: EndPointItem.delta, handler: { (deltaModel: HomeModel?, message: AlertMessage?) in
                if deltaModel != nil {
                    completionHandler(true, nil)
                }else {
                    completionHandler(false, message)
                }
            })
        }
    }
}
