//
//  Word_MatchApp.swift
//  Word Match
//
//  Created by Evgeniy on 01.05.2021.
//

import SwiftUI

@main
struct Word_MatchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), perform: { _ in
                    UserDefaults.standard.synchronize()
                })
        }
    }
}
