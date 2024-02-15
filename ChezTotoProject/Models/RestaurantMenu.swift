//
//  RestaurantMenu.swift
//  ChezTotoProject
//
//  Created by Yann Christophe Maertens on 21/11/2023.
//

import Foundation

struct RestaurantMenu: Codable, Hashable {
    let name: String
    let dishes: [Dish]
    
    enum CodingKeys: String, CodingKey {
        case name
        case dishes = "dishs"
    }
}
