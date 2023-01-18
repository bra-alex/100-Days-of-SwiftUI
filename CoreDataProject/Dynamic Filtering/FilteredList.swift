//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Don Bouncy on 17/12/2022.
//

import CoreData
import SwiftUI

enum FilterPredicate{
    case beginsWith, contains, endsWith, beginsWithC, containsC, endsWithC
    
    var predicate: String{
        switch self{
            case .beginsWith: return "BEGINSWITH"
            case .contains: return "CONTAINS"
            case .endsWith: return "ENDSWITH"
            case .beginsWithC: return "BEGINSWITH[c]"
            case .containsC: return "CONTAINS[c]"
            case .endsWithC: return "ENDSWITH[c]"
        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterPredicate: FilterPredicate, filterValue: String, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping(T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filterPredicate.predicate) %@", filterKey, filterValue))
        self.content = content
    }
}
