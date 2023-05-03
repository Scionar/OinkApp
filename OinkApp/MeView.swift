//
//  MeView.swift
//  OinkChat
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct MeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var offset: CGFloat = 0
    @State var tabBarOffset: CGFloat = 0
    @State var currentTab = "Posts"
    
    @Namespace var animation
    
    @State var headerTitleOffset: CGFloat = 0;
    
    var safeArea: EdgeInsets

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 15) {
                GeometryReader{proxy -> AnyView in

                    let minY = proxy.frame(in: .global).minY

                    DispatchQueue.main.async {
                        self.offset = minY
                    }

                    return AnyView(
                        ZStack{
                            Image("super-sundae")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                                .cornerRadius(0)

                            Blur()
                                .opacity(blurViewOpacity())
                            
                            // Header title
                            VStack(spacing: 5) {
                                Text("Piggy")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("150 Posts")
                                    .foregroundColor(.white)
                            }
                            .offset(y: 120)
                            .offset(y: headerTitleOffset > 100 ? 0 : -getHeaderTitleOffset())
                            .opacity(headerTitleOffset < 110 ? 1 : 0)
                        }
                            .clipped()
                            .frame(height: minY > 0 ? 180 + minY : nil)
                            .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                }
                .frame(height: 180)
                .coordinateSpace(name: "SCROLL")
                .zIndex(1)

                VStack{
                    // Avatar & edit button
                    HStack {
                        Image("pig")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(5)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .clipShape(Circle())
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .offset(x: -5)
                            .scaleEffect(getScale())

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
                    .overlay(
                        GeometryReader{proxy -> Color in
                            let minY = proxy.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.headerTitleOffset = minY
                            }
                            
                            return Color.clear
                        }.frame(width: 0, height: 0),
                        alignment: .top
                    )
                    .padding(.horizontal)
                    
                    GeometryReader{ proxy in
                        let minY = proxy.frame(in: .named("SCROLL")).minY - 50
                        
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                HStack(spacing: 0){
                                    TabButton(title: "Posts", currentTab: $currentTab, animation: animation)
    
                                    TabButton(title: "Media", currentTab: $currentTab, animation: animation)
    
                                    TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
    
                                    TabButton(title: "Calories", currentTab: $currentTab, animation: animation)
                                }
                            })
    
                            Divider()
                        }
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .offset(y: minY < 50 ? -(minY - 50) : 0)
                    }
                    .frame(height: 50)
                    .zIndex(1)
                    
                    // Posts
                    VStack(spacing: 18) {
                        PostBox(post: "Today I went to a pizza buffet! 🍕🍕 So awesome andfilling.", postImage: "veggie-pizza")
                        
                        Divider()
                        
                        ForEach(1...20, id: \.self) {_ in
                            PostBox(post: "Today I went to a pizza buffet! 🍕🍕 So awesome andfilling.")
                            Divider()
                        }
                    }
                    .padding(.top, 10)
                    .zIndex(0)
                }
                // Move view behind header if it goes > 80.
                .zIndex(-offset > 80 ? 0 : 1)
                
                

            }
        })
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func getHeaderTitleOffset()->CGFloat {
        let progress = 20 / headerTitleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }

    // Profile shrinking effect
    func getOffset()->CGFloat{
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress : 20
    }

    func getScale()->CGFloat{
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        return scale < 1 ? scale : 1
    }

    func blurViewOpacity()->Double{
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            MeView(safeArea: safeArea)
        }
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

struct TabButton: View {
    var title: String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation {
                currentTab = title
            }
        }, label:  {
            LazyVStack(spacing: 0) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .frame(height: 49)
                
                if currentTab == title {
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                }
            }
            .frame(height: 50)
        })
    }
}
