//
//  Data.swift
//  Bookworm
//
//  Created by Don Bouncy on 10/12/2022.
//

import SwiftUI

struct Data: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }.listStyle(.plain)
            
//            Button("Add") {
//                let firstNames = ["Kwabena", "Ciel", "Yaa", "Afia", "Connie"]
//                let lastNames = ["Winston", "Blankson", "Rockson", "Forson", "Dickson"]
//                
//                let firstName = firstNames.randomElement()!
//                let lastName = lastNames.randomElement()!
//                
//                let student = Student(context: moc)
//                student.id = UUID()
//                student.name = "\(firstName) \(lastName)"
//                
//                try? moc.save()
//            }
        }
    }
}

struct Data_Previews: PreviewProvider {
    static var previews: some View {
        Data()
    }
}
