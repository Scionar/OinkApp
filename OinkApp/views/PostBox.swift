//
//  PostBox.swift
//  OinkApp
//
//  Created by Joona Viertola on 1.5.2023.
//

import SwiftUI

struct PostBox: View {
    @Binding var post: Post
//    var post: String
    var avatarImage: String?
    var postImage: String?
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 10, content: {
            if let avatar = avatarImage {
                Image(avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 3, content: {
                (
                    Text("Piggy ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    +
                    
                    Text("@piggy5000")
                        .foregroundColor(.gray)
                )
                
                if let text = post.post {
                    Text(text)
                        .frame(maxHeight: 100, alignment: .top)
                }
                
                if let image = postImage {
                    GeometryReader{proxy in
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.frame(in: .global).width, height: 250)
                            .cornerRadius(15)
                    }
                    .frame(height: 250)
                    .padding(.top, 10)
                }
            })
        }).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

struct PostBox_Previews: PreviewProvider {
    static var previews: some View {
        PostBox(post: .constant(Post.sampleProfileFeedData[0]))
    }
}
