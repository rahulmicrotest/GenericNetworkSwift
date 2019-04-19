//
//  HomeViewController.swift
//  DeltaTest
//
//  Created by Rahul Singh on 18/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

class HomeViewController: UIViewController {

    private let homeViewModel = HomeViewModel()
    private let aboutCanadaViewModel = AboutCanadaViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        aboutCanadaViewModel.fetchTelstraData{(status, errorMsg) in
            switch status {
            case true: print(status)
            case false: print(errorMsg!)
            }
        }
     }
}

