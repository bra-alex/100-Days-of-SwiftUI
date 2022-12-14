//
//  Constraints.swift
//  CoreDataProject
//
//  Created by Don Bouncy on 17/12/2022.
//

import SwiftUI

struct Constraints: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id:\.self) { wizard in
                Text(wizard.name ?? "N/A")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Kyeiwaa"
            }
            
            Button("Save"){
                do{
                    try  moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct Constraints_Previews: PreviewProvider {
    static var previews: some View {
        Constraints()
    }
}
