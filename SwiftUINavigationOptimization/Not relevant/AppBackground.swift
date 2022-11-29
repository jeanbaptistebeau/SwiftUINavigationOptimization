//
//  AppBackground.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 23/06/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct AppBackground: View {
    var body: some View {
        BlurView(style: .dark)
            .background(
                Image("app_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct AppBackground_Previews: PreviewProvider {
    static var previews: some View {
        AppBackground()
    }
}
