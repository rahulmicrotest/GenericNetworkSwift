//
//  AboutCanadaModel.swift
//  AboutCanada
//
//  Created by Rahul Singh on 31/03/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation

struct AboutCanada: Codable {
    let title: String?
    let rows: [Rows]
}


struct Rows: Codable {
    let title: String?
    let description: String?
    let imageHref: URL?
}
