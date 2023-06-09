//
//  FloatingButton.swift
//  OinkApp
//
//  Created by Joona Viertola on 4.5.2023.
//

import SwiftUI

struct FloatingButtonContainer: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {}
                .buttonStyle(FloatingButton())
                .offset(x: -15, y: -75)
            }
        }
    }
}

struct FloatingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 15, height: 15)
            configuration.label
        }
        .frame(width: 55, height: 55, alignment: .center)
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y:0)
    }
}

struct FloatButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FloatingButtonContainer(action: {
                print("Button pressed!")
            })
        }
    }
}
