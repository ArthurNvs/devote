//
//  DevoteApp.swift
//  Devote
//
//  Created by Arthur Neves on 06/12/21.
//

import SwiftUI

@main
struct DevoteApp: App {
  let persistenceController = PersistenceController.shared
  
  @AppStorage("isDarkMode") var isDarkMode = false
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .preferredColorScheme(isDarkMode ? . dark : .light)
    }
  }
}
