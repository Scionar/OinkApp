//
//  PostEditView.swift
//  OinkApp
//
//  Created by Joona Viertola on 5.5.2023.
//

import SwiftUI

struct PostEditView: View {
    @Binding var post: Post
    @State private var newPost = ""

    var body: some View {
        Form {
            Section(header: Text("Post")) {
                TextEditor(text: $post.post)
            }
        }
    }
}

struct PostEditView_Previews: PreviewProvider {
    static var previews: some View {
        PostEditView(post: .constant(Post.sampleProfileFeedData[0]))
    }
}
