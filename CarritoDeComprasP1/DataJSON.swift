//
//  DataJSON.swift
//  CarritoDeComprasP1
//
//  Created by Emiliano Alfredo Martínez Vázquez on 3/30/19.
//  Copyright © 2019 Emiliano Alfredo Martínez Vázquez All rights reserved.

import Foundation

struct Results: Codable  {
    var resultCount : Int
    var results: [Products]
}

struct Products: Codable {
    var name: String
    var image: String
    var detail: String
    var description: String
    var price: Double
}
struct Buy: Codable {
    var name: String
    var qty: Int
    var price: Double
}
