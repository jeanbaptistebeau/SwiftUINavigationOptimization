//
//  VibrantBackground.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 23/06/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

fileprivate let defaultCornerRadius: CGFloat = 16
fileprivate let defaultOpacity: CGFloat = 0.4

struct VibrantBackgroundView: View {
    var cornerRadius: CGFloat = defaultCornerRadius
    var opacity: CGFloat = defaultOpacity

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius).vibrant(opacity: opacity)
    }
}

struct VibrantBackground: ViewModifier {
    var cornerRadius: CGFloat
    var opacity: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                VibrantBackgroundView(cornerRadius: cornerRadius, opacity: opacity)
            )
    }
}

struct RoundVibrantBackground: ViewModifier {
    var opacity: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                Circle().vibrant(opacity: opacity)
            )
    }
}

extension View {
    func vibrantBackground(cornerRadius: CGFloat = defaultCornerRadius, opacity: CGFloat? = nil) -> some View {
        modifier(VibrantBackground(cornerRadius: cornerRadius, opacity: opacity ?? defaultOpacity))
    }
    
    func roundVibrantBackground(opacity: CGFloat? = nil) -> some View {
        modifier(RoundVibrantBackground(opacity: opacity ?? defaultOpacity))
    }
}


// MARK: - "Fake Overlay" Effect

fileprivate let vibrantFillOpacityRatio: CGFloat = 0.27

extension Shape {
    
    func vibrant(opacity: CGFloat) -> some View {
        // Replace old overlay effect
        fill(Color(Colors.hexStringToUIColor(hex: "757DFF")).opacity(opacity * vibrantFillOpacityRatio))
    }
    
}

extension View {

    func vibrant(opacity: CGFloat) -> some View {
        foregroundColor(Color(Colors.hexStringToUIColor(hex: "757DFF")).opacity(opacity * vibrantFillOpacityRatio))
    }

}
