//
//  MeView.swift
//  OinkChat
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct MeView: View {
    @State var offset: CGFloat = 0
    @State var currentTab = "Posts"
    
    @Namespace var animation

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

                            BlurView()
                                .opacity(blurViewOpacity())
                        }
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                }
                .frame(height: 180)
                .zIndex(1)

                VStack{
                    HStack {
                        // Avatar
                        Image("pig")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(5)
                            .background(Color.white)
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
                    
                    // Segmented menu
                    VStack(spacing: 0){
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
                    .padding(.top, 20)
                }
                .padding(.horizontal)
                // Move view behind header if it goes > 80.
                .zIndex(-offset > 80 ? 0 : 1)
                
                

            }
        })
        .ignoresSafeArea(.all, edges: .top)
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
        MeView()
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
            LazyVStack(spacing: 12) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                
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
        })
    }
}
