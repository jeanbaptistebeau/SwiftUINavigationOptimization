//
//  TextStyle.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 23/06/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

// MARK: - Models

enum FontSize {
    case tiny, small, normal
    case h1, h2, h3, h4
    case custom(CGFloat)
    
    var size: CGFloat {
        switch self {
        case .tiny: return 13
        case .small: return 15
        case .normal: return 17
        case .h1: return 36
        case .h2: return 28
        case .h3: return 24
        case .h4: return 20
        case .custom(let value): return value
        }
    }
    
    static var all: [FontSize] { [.tiny, .small, .normal, .h1, .h2, .h3, .h4] }
}

enum FontWeight: String, CaseIterable {
    case regular = "SourceSansPro-Regular"
    case semiBold = "SourceSansPro-SemiBold"
    case bold = "SourceSansPro-Bold"
    case black = "SourceSansPro-Black"
}

struct TextStyle {
    var size: FontSize
    var weight: FontWeight
    var color: Color? = .white
    
    var font: Font {
        Font.custom(weight.rawValue, size: size.size)
    }

    var uiFont: UIFont {
        UIFont(name: weight.rawValue, size: size.size)!
    }
    
    var uiColor: UIColor? {
        if let color = color { return UIColor(color) }
        else { return nil }
    }
}


// MARK: - Keys

private struct TextStyleKey: EnvironmentKey {
    static let defaultValue: TextStyle = TextStyle(size: .normal, weight: .regular)
}

extension EnvironmentValues {
    var textStyle: TextStyle {
        get { self[TextStyleKey.self] }
        set { self[TextStyleKey.self] = newValue }
    }
}


// MARK: - Views & Modifiers

struct TextStyleModifier: ViewModifier {
    var style: TextStyle

    func body(content: Content) -> some View {
        if let color = style.color {
            content
                .foregroundColor(color)
                .font(style.font)
                .environment(\.textStyle, style)
        }
        else {
            content
                .font(style.font)
                .environment(\.textStyle, style)
        }
    }
}

extension View {
    func textStyle(size: FontSize, weight: FontWeight, color: Color? = .white) -> some View {
        modifier(TextStyleModifier(style: TextStyle(size: size, weight: weight, color: color)))
    }
}


struct GlobalModifiers_Previews: PreviewProvider {
    static var previews: some View {
        Preview(type: .scroll) {
            VStack(spacing: 30) {
                ForEach([Color.white, Color.white60, Color.white30, nil], id: \.self) { color in
                    HStack(spacing: 0) {
                        ForEach(FontWeight.allCases, id: \.rawValue) { weight in
                            VStack {
                                ForEach(FontSize.all, id: \.size) { size in
                                    Text("Oniri")
                                        .textStyle(size: size, weight: weight, color: color)
                                        .foregroundColor(.dangerousRed)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            }
        }
    }
}
