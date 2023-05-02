//
//  BrowseView.swift
//  OinkChat
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct BrowseView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    ForEach(1...20, id: \.self) {_ in
                        PostBox(post: "Today I went to a pizza buffet! 🍕🍕 So awesome and filling.")
                        Divider()
                    }
                }
                .padding(.top, 20)
            })
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {}) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
