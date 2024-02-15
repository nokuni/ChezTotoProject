//
//  Restaurant.swift
//  ChezTotoProject
//
//  Created by Yann Christophe Maertens on 21/11/2023.
//

import Foundation
import Utility_Toolbox

struct Restaurant: Codable {
    let name: String
    let schedules: [Schedule]
    let address: String
    let website: String
    let phoneNumber: String
}

extension Restaurant {
    
    static var all: [Restaurant] {
        do {
            let restaurants: [Restaurant] = try BundleManager().decodeJSON("restaurants.json")
            return restaurants
        } catch {
            fatalError()
        }
    }
    
    static func get(name: String) -> Restaurant? {
        let restaurant = Restaurant.all.first(where: { $0.name == name })
        return restaurant
    }
}
