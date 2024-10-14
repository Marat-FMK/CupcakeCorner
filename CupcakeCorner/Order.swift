//
//  Order.swift
//  CupcakeCorner
//
//  Created by Marat Fakhrizhanov on 10.10.2024.
//

import SwiftUI

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAdress = "streetAdress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chokolate", "Rafaello"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = UserDefaults.standard.string(forKey: "name") ?? "" { // без констано и енамов
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    
    var streetAdress = UserDefaults.standard.string(forKey: Constants.UD.streetAdress) ?? "" { // с применением констанм без ошибок
        didSet {
            UserDefaults.standard.set(streetAdress, forKey: Constants.UD.streetAdress)
        }
    }
    
    var city = UserDefaults.standard.string(forKey: Constants.UD.city) ?? "" {
        didSet{
            UserDefaults.standard.set(city, forKey: Constants.UD.city)
        }
    }
    
    var zip = UserDefaults.standard.string(forKey: Constants.UD.zip) ?? "" {
        didSet {
            UserDefaults.standard.set(zip, forKey: Constants.UD.zip)
        }
    }
    
    var hasValidAdress: Bool {
        if name.isEmpty||streetAdress.isEmpty||city.isEmpty||zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
