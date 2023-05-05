//
//  NewPostSheet.swift
//  OinkApp
//
//  Created by Joona Viertola on 5.5.2023.
//

import SwiftUI

struct NewPostSheet: View {
    @State private var newPost = Post.emptyPost
    @Binding var posts: [Post]
    @Binding var isPresentingNewPostView: Bool
    
    var body: some View {
        NavigationStack {
            PostEditView(post: $newPost)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewPostView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            posts.append(newPost)
                            isPresentingNewPostView = false
                        }
                    }
                }
        }
    }
}

struct NewPostSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewPostSheet(posts: .constant(Post.sampleProfileFeedData), isPresentingNewPostView: .constant(true))
    }
}
