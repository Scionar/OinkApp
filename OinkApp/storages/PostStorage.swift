//
//  PostStorage.swift
//  OinkApp
//
//  Created by Joona Viertola on 3.5.2023.
//

import SwiftUI

@MainActor
class PostStorage: ObservableObject {
    @Published var posts: [Post] = []
    @Published var browsePosts: [Post] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
    
    func load() async throws {
        let task = Task<[Post], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let postsFromFile = try JSONDecoder().decode([Post].self, from: data)
            return postsFromFile
        }

        let posts = try await task.value
        self.posts = posts
    }
    
    func save(posts: [Post]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(posts)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
