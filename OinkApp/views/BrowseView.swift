//
//  BrowseView.swift
//  OinkApp
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct BrowseView: View {
    @Binding var posts: [Post]

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 18) {
                    ForEach($posts, id: \.id) {post in
                        PostBox(post: post, avatarImage: "pig", deleteAction: { print("Delete action") })
                        Divider()
                    }
                }
                .padding(.top, 20)
            })
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {}) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle").foregroundColor(.gray)
                }
            }
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView(posts: .constant(Post.sampleFollowingFeedData))
    }
}
