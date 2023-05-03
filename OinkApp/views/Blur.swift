//
//  BlurView.swift
//  OinkApp
//
//  Created by Joona Viertola on 30.4.2023.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {

    }
}
