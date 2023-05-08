//
//  StickyHeader.swift
//  OinkApp
//
//  Created by Joona Viertola on 5.5.2023.
//

import SwiftUI

struct StickyHeader<Content: View>: View {
    var minHeight: CGFloat
    var offset: CGFloat
    var content: Content
    
    init(minHeight: CGFloat = 200, offset: CGFloat = 0, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.offset = offset
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .global).minY
            
            if (minY <= 0) {
                content
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            } else {
                content
                    .offset(y: -minY)
                    .frame(width: geo.size.width, height: geo.size.height + minY)
            }
        }
        .frame(minHeight: minHeight)
    }
}

struct StickyHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            StickyHeader {
                Image("super-sundae")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        
    }
}
