//
//  StickyHeader.swift
//  OinkApp
//
//  Created by Joona Viertola on 5.5.2023.
//

import SwiftUI

struct StickyHeader: View {
    var minHeight: CGFloat
    var offset: CGFloat
    
    init(minHeight: CGFloat = 200, offset: CGFloat = 0) {
        self.minHeight = minHeight
        self.offset = offset
    }
    
    var body: some View {
        GeometryReader{proxy -> AnyView in
            return AnyView(
                ZStack{
                    Image("super-sundae")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRect().width, height: self.offset > 0 ? 180 + self.offset : 180, alignment: .center)
                        .cornerRadius(0)

                    Blur()
                        .opacity(blurViewOpacity())

                    // Header title
                    VStack(spacing: 0) {
                        Text("Piggy")
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("150 Posts")
                            .foregroundColor(.white)
                    }
                    .offset(y: 63)
                    .opacity(self.offset < -150 ? 1 : blurViewOpacity())
                }
                    .clipped()
                    .frame(height: self.offset > 0 ? 180 + self.offset : nil)
                    .offset(y: self.offset > 0 ? -self.offset : -self.offset < 80 ? 0 : -self.offset - 80)
            )
        }
        .frame(height: 180)
    }

    func blurViewOpacity()->Double{
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
}

struct StickyHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            StickyHeader()
        }
        
    }
}
