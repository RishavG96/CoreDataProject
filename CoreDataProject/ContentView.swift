//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Rishav Gupta on 20/06/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    
    // ForEach how it can identify each view uniquely.
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Star Wars", "Aliens"])) var ships: FetchedResults<Ship>
    // %@ -> give input elsewhere
    // [c] -> to make case insensitive
    // BEGINSWITH[c]
    
    
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            List {
                ForEach([2, 4, 6, 8, 10] , id: \.self) {
                    // \.self swift computes the hash value of the struct which is a way of representing complex information to a single fixed value that represents uniquely. Regardless of the input size, the output should be the same size of that hash value. Secondly, calculating the same hash for the same object, twice in a row should retun the same value.
                    // When you have that hash value, you cannot convert that back to the original value.
                    // XCode generates a class of all the managed objects we create as entities in our data model. It then makes that class conform to swift's hashable protocol. Now it can make hash value for an object. Which in turn means, we can use \.self. Ask for a whole hash for a whole object and use that for its identifier.
                    // String and Int also conform to hashable
                    // Core Data create a unique id property for us which uniquely identify data, similar to UUID but it is made sequentially so that it can track how many times its made over time. But still guarantee to be unique.
                    
                    // When we create a new Core data entity, XCODE automatically generated a Managed object class we can use in our code. We can use the SwiftUI FetchRequest to pull it into our UI
                    
                    // Codegen-> Manual
                    // Editor -> Create NSManagedObject subclass
                    
                    // CoreData is lazy - > CoreData has all the properties but it does not load it, when you ask for a property then it loads it.
                    
                    // CoreData can add any data, even if they are identical. Storing 2 or more contains by email adress should not happen. CoreData uses contraints which makes it unique. When we say save(), it will go ahead and resolve the duplicates for us and remove them all so that only 1 piece of data remains.
                    
                    
                    Text("\($0) is even")
                }
            }
             
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "UNKNOWN")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "UNKNOWN")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Mellinium"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Execitor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
            
            
            
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
