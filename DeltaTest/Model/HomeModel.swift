//
//  HomeModel.swift
//  DeltaTest
//
//  Created by Rahul Singh on 18/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation

struct HomeModel: Codable {
    
    let type: String?
    let length: Int?
    let data: [Int]?
    let success: Bool?
}
