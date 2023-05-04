//
//  ProfileTabsTabs.swift
//  OinkApp
//
//  Created by Joona Viertola on 4.5.2023.
//

import SwiftUI

struct ProfileTabs: View {
    @Binding var currentTab: String;
    
    @Environment(\.colorScheme) var colorScheme
    
    @Namespace var animation
    
    var body: some View {
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


struct ProfileTabsTabs_Previews: PreviewProvider {
    static var previews: some View {
        @State var currentTab = "Posts"
        ProfileTabs(currentTab: $currentTab)
    }
}
