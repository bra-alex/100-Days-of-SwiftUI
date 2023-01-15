//
//  Filtering.swift
//  CoreDataProject
//
//  Created by Don Bouncy on 17/12/2022.
//

import CoreData
import SwiftUI

struct Filtering: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship> //EXACT
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Marvel", "DC", "Star Trek"])) var ships: FetchedResults<Ship> //ARRAY
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", "E")) var ships: FetchedResults<Ship> //CASE SENSITIVE
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship> //CASE INSENSITIVE
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS %@", "T")) var ships: FetchedResults<Ship> //CASE SENSITIVE
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS[c] %@", "T")) var ships: FetchedResults<Ship> //CASE INSENSITIVE
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name CONTAINS[c] %@", "T")) var ships: FetchedResults<Ship> //NEGATION
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "N/A")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
        }
    }
}

struct Filtering_Previews: PreviewProvider {
    static var previews: some View {
        Filtering()
    }
}
