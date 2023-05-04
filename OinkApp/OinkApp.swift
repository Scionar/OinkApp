//
//  OinkApp.swift
//  OinkApp
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

@main
struct OinkChatApp: App {
    @StateObject private var store = PostStorage()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
