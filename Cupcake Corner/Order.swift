//
//  Order.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 09/12/2022.
//

import SwiftUI

struct Order: Codable{
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var completeDetails: Bool{
        let name = name.trimmingCharacters(in: .whitespaces)
        let streetAddress = streetAddress.trimmingCharacters(in: .whitespaces)
        let city = city.trimmingCharacters(in: .whitespaces)
        let zip = zip.trimmingCharacters(in: .whitespaces)
        
        return name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty
    }
    
    var cost: Double{
        var cost = Double(quantity) * 2
        
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles{
            cost += Double(quantity)/2
        }
        
        return cost
    }
}


class Orders: ObservableObject{
    @Published var orders = Order()
}
