//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Rishav Gupta on 21/06/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptor: SortDescriptor<T>, predicateType: PredicateTypes, @ViewBuilder content: @escaping (T) -> Content) {
        let predicateType = predicateType.rawValue.uppercased()
        _fetchRequest = FetchRequest<T>(sortDescriptors: [
            sortDescriptor
        ], predicate: NSPredicate(format: "%K \(predicateType) %@", filterKey, filterValue)) // here we arent saying here is new results to load, we are giving it entirely new results to show.
        
        self.content = content
    }
}
