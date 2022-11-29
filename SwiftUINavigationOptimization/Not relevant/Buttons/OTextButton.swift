//
//  OTextButton.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 30/09/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct OTextButton: View {
    enum Width { case sizeToFit, fixed, flexible }
    enum Height: CGFloat { case small = 46, normal = 50, big = 55, huge = 60 }
    
    struct SizeStyle {
        var width: Width
        var height: Height
    }

    struct IconStyle {
        var image: Image?
        var alignment: TextAlignment
        var spacing: CGFloat
    }

    struct InsetStyle {
        var horizontal: CGFloat?
    }

    static let defaultTextStyle = TextStyle(size: .normal, weight: .bold, color: .white)
    static let defaultBackgroundStyle = OButtonStyle.BackgroundStyle(shape: .roundedRect, fill: .vibrant)
    static let defaultSizeStyle = SizeStyle(width: .sizeToFit, height: .normal)
    static let defaultIconStyle = IconStyle(image: nil, alignment: .leading, spacing: 8)
    static let defaultInsetStyle = InsetStyle(horizontal: nil)

    
    // MARK: - Attributes
    
    var action: () -> Void
    var text: String
    
    private var textStyle = OTextButton.defaultTextStyle
    private var backgroundStyle = OTextButton.defaultBackgroundStyle
    private var sizeStyle = OTextButton.defaultSizeStyle
    private var iconStyle = OTextButton.defaultIconStyle
    private var insetStyle = OTextButton.defaultInsetStyle
    
    
    // MARK: - Helpers

    var horizontalInsets: CGFloat {
        if let insets = insetStyle.horizontal { return insets }
        
        switch backgroundStyle.shape {
        case .roundedRect: return 40
        case .roundedRectCustom(_): return 40
        case .capsule: return 25
        case .circle: return 0
        }
    }

    
    // MARK: - Setup
    
    init(action: @escaping () -> Void, text: String) {
        self.action = action
        self.text = text
    }
    
    private init(copying button: OTextButton,
                 textStyle: TextStyle? = nil,
                 backgroundStyle: OButtonStyle.BackgroundStyle? = nil,
                 sizeStyle: OTextButton.SizeStyle? = nil,
                 iconStyle: OTextButton.IconStyle? = nil,
                 insetStyle: OTextButton.InsetStyle? = nil) {
        
        self.action = button.action
        self.text = button.text
        self.textStyle = textStyle ?? button.textStyle
        self.backgroundStyle = backgroundStyle ?? button.backgroundStyle
        self.sizeStyle = sizeStyle ?? button.sizeStyle
        self.iconStyle = iconStyle ?? button.iconStyle
        self.insetStyle = insetStyle ?? button.insetStyle
    }
        

    // MARK: - Views
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: iconStyle.spacing) {
                if iconStyle.alignment != .trailing { icon }
                Text(text)
                if iconStyle.alignment == .trailing { icon }
            }
            .frame(height: sizeStyle.height.rawValue)
            .frame(width: sizeStyle.width == .fixed ? OButtonStyle.fixedWidth : nil)
            .frame(maxWidth: sizeStyle.width == .flexible ? .infinity : nil)
            .padding(.horizontal, sizeStyle.width == .sizeToFit ? horizontalInsets : 0)
        }
        .buttonStyle(OButtonStyle(textStyle: textStyle, backgroundStyle: backgroundStyle))
    }
    
    @ViewBuilder
    var icon: some View {
        if let icon = iconStyle.image {
            icon
                .renderingMode(.template)
                .offset(y: 1)
        }
    }

    
}


extension OTextButton {
    
    func foreground(size: FontSize? = nil, weight: FontWeight? = nil, color: Color) -> OTextButton {
        OTextButton(copying: self, textStyle: TextStyle(size: size ?? OTextButton.defaultTextStyle.size,
                                                        weight: weight ?? OTextButton.defaultTextStyle.weight,
                                                        color: color))
    }
    
    func background(shape: OButtonStyle.BackgroundShape? = nil, style: OButtonStyle.BackgroundFill) -> OTextButton {
        OTextButton(copying: self, backgroundStyle: OButtonStyle.BackgroundStyle(shape: shape ?? OTextButton.defaultBackgroundStyle.shape, fill: style))
    }

    func size(width: Width? = nil, height: Height? = nil) -> OTextButton {
        OTextButton(copying: self, sizeStyle: SizeStyle(width: width ?? OTextButton.defaultSizeStyle.width,
                                                        height: height ?? OTextButton.defaultSizeStyle.height))
    }
    
    func icon(image: Image, alignment: TextAlignment? = nil, spacing: CGFloat? = nil) -> OTextButton {
        OTextButton(copying: self, iconStyle: IconStyle(image: image,
                                                        alignment: alignment ?? OTextButton.defaultIconStyle.alignment,
                                                        spacing: spacing ?? OTextButton.defaultIconStyle.spacing))
    }
    
    func inset(horizontal: CGFloat) -> OTextButton {
        OTextButton(copying: self, insetStyle: InsetStyle(horizontal: horizontal))
    }

}


// Note: Preview in `OButtons`
