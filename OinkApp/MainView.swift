//
//  MainView.swift
//  OinkApp
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets

            TabView() {
                BrowseView().tabItem {
                    Label("Browse", systemImage: "globe.europe.africa.fill")
                }
                ChannelListView()
                    .badge(3)
                    .tabItem {
                        Label("Following", systemImage: "person.2.fill")
                    }
                MeView(safeArea: safeArea).tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
            }
            .tabViewStyle(DefaultTabViewStyle())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
