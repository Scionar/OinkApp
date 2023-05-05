//
//  MainView.swift
//  OinkApp
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var store = PostStorage()

    @State private var editingPost = Post.emptyPost
    @State private var isPresentingNewPostView = false

    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets

            ZStack {
                TabView() {
                    BrowseView(posts: $store.browsePosts).tabItem {
                        Label("Browse", systemImage: "globe.europe.africa.fill")
                    }
                    ChannelListView()
                        .badge(3)
                        .tabItem {
                            Label("Following", systemImage: "person.2.fill")
                        }
                    MeView(safeArea: safeArea, posts: $store.posts).tabItem {
                        Label("Profile", systemImage: "person.crop.circle.fill")
                    }
                }
                .tabViewStyle(DefaultTabViewStyle())
                .task {
                    do {
                        try await store.load()
                    }
                    catch {
                        fatalError(error.localizedDescription)
                    }
                }
                .sheet(isPresented: $isPresentingNewPostView) {
                    NewPostSheet(
                        posts: $store.posts,
                        isPresentingNewPostView: $isPresentingNewPostView
                    )
                }
                
                FloatingButtonContainer(action: {
                    isPresentingNewPostView = true
                })
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
