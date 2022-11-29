//
//  OButton.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 23/06/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

// MARK: - Button style

struct OButtonStyle: ButtonStyle {
    static let fixedWidth: CGFloat = 272
    private let defaultVibrantOpacity: CGFloat = 0.4
    
    enum BackgroundShape { case roundedRect, roundedRectCustom(CGFloat), capsule, circle }
    enum BackgroundFill { case white, vibrant, vibrantCustom(CGFloat), transparent, custom(Color), gradient, darkBlur }

    struct BackgroundStyle {
        var shape: BackgroundShape
        var fill: BackgroundFill
    }

    
    // MARK: - Attributes

    var textStyle: TextStyle
    var backgroundStyle: BackgroundStyle
    var scaleOnPress: Bool = true
    
    
    // MARK: - Views
    
    @ShapeBuilder
    var backgroundShape: some Shape {
        switch backgroundStyle.shape {
        case .roundedRect: RoundedRectangle(cornerRadius: 16)
        case .roundedRectCustom(let radius): RoundedRectangle(cornerRadius: radius)
        case .capsule: Capsule()
        case .circle: Circle()
        }
    }
    
    @ViewBuilder
    func background(isPressed: Bool) -> some View {
        switch backgroundStyle.fill {
        case .transparent:
            backgroundShape.fill(Color.clear)
        case .white:
            backgroundShape.fill(Color.white)
        case .custom(let color):
            backgroundShape.fill(color)

        case .vibrant:
            backgroundShape.vibrant(opacity: defaultVibrantOpacity + (isPressed ? 0.4 : 0))
        case .vibrantCustom(let alpha):
            backgroundShape.vibrant(opacity: alpha + (isPressed ? 0.4 : 0))
            
        case .darkBlur:
            BlurView(style: .dark).clipShape(backgroundShape)
            
        case .gradient:
            LinearGradient(colors: [.gradientCyan, .gradientPink],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .background(Rectangle().vibrant(opacity: 0.4))
            .clipShape(backgroundShape)
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(size: textStyle.size, weight: textStyle.weight, color: textStyle.color?.opacity(configuration.isPressed ? 0.5 : 1))
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            .background(
                background(isPressed: configuration.isPressed)
                    .animation(.linear(duration: 0.1), value: configuration.isPressed)
                    .scaleEffect(scaleOnPress && configuration.isPressed ? 1.05 : 1)
                    .animation(.spring(response: 0.2, dampingFraction: 0.4), value: configuration.isPressed)
            )
    }
}

extension OButtonStyle {
    
    init(foregroundColor: Color, backgroundStyle: BackgroundStyle) {
        self.init(textStyle: TextStyle(size: .normal, weight: .bold, color: foregroundColor),
                  backgroundStyle: backgroundStyle)
    }
    
}


// MARK: - Icon buttons

struct OIconButton: View {
    var action: (() -> Void)
    var icon: Image
    var iconScaling: CGFloat = 1
    var size: CGFloat
    var foregroundColor: Color
    var backgroundFill: OButtonStyle.BackgroundFill
    
    var body: some View {
        Button(action: action) {
            icon
                .renderingMode(.template)
                .frame(width: size, height: size, alignment: .center)
                .scaleEffect(iconScaling)
        }
        .buttonStyle(OButtonStyle(
            foregroundColor: foregroundColor,
            backgroundStyle: OButtonStyle.BackgroundStyle(shape: .circle, fill: backgroundFill)
        ))
    }
}

extension OIconButton {
    enum IconType {
        case back, cancel, trash, share, edit, download
        
        var image: Image {
            switch self {
            case .back: return Image("back")
            case .cancel: return Image("cancel")
            case .trash: return Image("trash")
            case .share: return Image("share")
            case .edit: return Image("edit")
            case .download: return Image("download_song")
            }
        }
    }

    static func navigation(_ type: IconType, foregroundColor: Color, backgroundStyle: OButtonStyle.BackgroundFill, action: @escaping (() -> Void)) -> OIconButton {
        OIconButton(action: action,
                    icon: type.image,
                    size: 50,
                    foregroundColor: foregroundColor,
                    backgroundFill: backgroundStyle)
    }
    
}
