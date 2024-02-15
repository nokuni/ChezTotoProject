//
//  DIsh.swift
//  ChezTotoProject
//
//  Created by Yann Christophe Maertens on 21/11/2023.
//

import Foundation

struct Dish: Codable, Hashable {
    let name: String
    let description: String
    let pictureName: String
    let price: Double
}
