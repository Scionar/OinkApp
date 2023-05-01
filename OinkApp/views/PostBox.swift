//
//  PostBox.swift
//  OinkApp
//
//  Created by Joona Viertola on 1.5.2023.
//

import SwiftUI

struct PostBox: View {
    var post: String
    var postImage: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 10, content: {
            Image("pig")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 10, content: {
                (
                    Text("Piggy ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    +
                    
                    Text("@piggy5000")
                        .foregroundColor(.gray)
                )
                
                Text(post)
                    .frame(maxHeight: 100, alignment: .top)
                
                if let image = postImage {
                    GeometryReader{proxy in
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.frame(in: .global).width, height: 250)
                            .cornerRadius(15)
                    }
                    .frame(height: 250)
                }
            })
        }).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

struct PostBox_Previews: PreviewProvider {
    static var previews: some View {
        PostBox(post: "Post content!")
    }
}
