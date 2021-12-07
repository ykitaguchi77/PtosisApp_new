//
//  PtosisAppApp.swift
//  PtosisApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/12/07.
//

import SwiftUI

@main
struct PtosisApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
