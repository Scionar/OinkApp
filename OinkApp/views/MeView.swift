//
//  MeView.swift
//  OinkApp
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct MeView: View {
    var safeArea: EdgeInsets
    @Binding var posts: [Post]
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var offset: CGFloat = 0
    @State var tabBarOffset: CGFloat = 0
    @State var currentTab = "Posts"
    @State var headerTitleOffset: CGFloat = 0;
    
    @Namespace var animation

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            
            
            VStack(spacing: 15) {
                StickyHeader(minHeight: 180, offset: self.offset)
                    .coordinateSpace(name: "SCROLL")
                    .zIndex(1)
                
                VStack{
                    // Avatar & edit button
                    HStack {
                        Avatar()
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Edit Profile")
                                .foregroundColor(.blue)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(
                                    Capsule().stroke(Color.blue, lineWidth: 1.5)
                                )
                        })
                    }
                    .padding(.top, -25)
                    .padding(.bottom, -10)
                    .padding(.horizontal)
                    
                    // Profile description
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Piggy")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Text("@piggy5000")
                            .foregroundColor(.gray)
                        
                        Text("Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula.")
                    })
                    .padding(.horizontal)
                    .overlay(
                        GeometryReader{proxy -> Color in
                            let minY = proxy.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.headerTitleOffset = minY
                            }
                            
                            return Color.clear
                        },
                        alignment: .top
                    )
                    
                    GeometryReader{ proxy in
                        let minY = proxy.frame(in: .named("SCROLL")).minY - 50
                        
                        ProfileTabs(currentTab: $currentTab)
                            .offset(y: minY < 50 ? -(minY - 50) : 0)
                    }
                    .frame(height: 50)
                    .zIndex(1)
                    
                    // Posts
                    VStack(spacing: 18) {
                        ForEach($posts.indices, id: \.self) { index in
                            PostBox(post: $posts[index], deleteAction: {
                                posts.remove(atOffsets: IndexSet([index]))
                            })
                            Divider()
                        }
                    }
                    .padding(.top, 10)
                    .zIndex(0)
                }
                // Move view behind header if it goes > 80.
                .zIndex(-offset > 80 ? 0 : 1)
                
                
                
            }
            .overlay(
                GeometryReader{proxy -> Color in
                    let minY = proxy.frame(in: .global).minY

                    DispatchQueue.main.async {
                        self.offset = minY
                    }

                    return Color.clear
                },
                alignment: .top
            )
        })
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            MeView(safeArea: safeArea, posts: .constant(Post.sampleProfileFeedData))
        }
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

struct Avatar: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image("pig")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 75)
            .clipShape(Circle())
            .padding(5)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .clipShape(Circle())
    }
}
