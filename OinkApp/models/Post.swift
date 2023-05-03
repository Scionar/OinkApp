//
//  Post.swift
//  OinkApp
//
//  Created by Joona Viertola on 3.5.2023.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: UUID
    let date: Date
    let avatar: String?
    let post: String?
    let postImage: String?
    
    init(id: UUID = UUID(), date: Date = Date(), avatar: String? = nil, post: String?, postImage: String? = nil) {
        self.id = id
        self.date = date
        self.avatar = avatar
        self.post = post
        self.postImage = postImage
    }

}

extension Post {
    static let sampleFollowingFeedData: [Post] = [
        Post(
            avatar: "pig",
            post: "It's such a beautiful day! ☀️"
        ),
        Post(
            avatar: "pig",
            post: "We had a pizza buffet today.",
            postImage: "veggie-pizza"
        ),
        Post(
            avatar: "pig",
            post: "It was a dark and storymy night. Fridge was luring people people out from their beds to fill in the middle of the night"
        )
    ]
    
    static let sampleProfileFeedData: [Post] = [
        Post(
            post: "It's such a beautiful day! ☀️"
        ),
        Post(
            post: "We had a pizza buffet today.",
            postImage: "veggie-pizza"
        ),
        Post(
            post: "It was a dark and storymy night. Fridge was luring people people out from their beds to fill in the middle of the night"
        )
    ]
}
