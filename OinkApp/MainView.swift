//
//  MainView.swift
//  OinkApp
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {

        TabView() {
            BrowseView().tabItem {
                Label("Browse", systemImage: "person.2.fill")
            }
            ChannelListView()
                .badge(3)
                .tabItem {
                    Label("Channels", systemImage: "bubble.right.fill")
                }
            MeView().tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
