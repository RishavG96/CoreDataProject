//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Rishav Gupta on 20/06/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
