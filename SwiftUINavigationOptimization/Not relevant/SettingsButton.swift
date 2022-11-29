//
//  SUISettingsButton.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 05/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct SettingsButton: View {
    @Environment(\.relativeOrder) var relativeOrder

    var action: () -> Void
    var title: String
    var subtitle: String? = nil
    var icon: Image
    var isDangerous: Bool = false

    var roundedCorners: UIRectCorner {
        switch relativeOrder {
        case .first: return [.topLeft, .topRight]
        case .middle: return []
        case .last: return [.bottomLeft, .bottomRight]
        case .alone: return .allCorners
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 12) {
                VStack {
                    iconView
                    if subtitle != nil { Spacer() }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .textStyle(size: .normal, weight: .bold, color: isDangerous ? .dangerousRed : .white)
                        .multilineTextAlignment(.leading)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .textStyle(size: .small, weight: .regular, color: .white30)
                            .multilineTextAlignment(.leading)
                    }
                }
                                
                Spacer()
                
                Image("next")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 25)
            .vibrantBackground(cornerRadius: 0)
            .cornerRadius(16, corners: roundedCorners)
        }
    }
    
    @ViewBuilder
    var iconView: some View {
        if isDangerous {
            icon.renderingMode(.template).foregroundColor(.dangerousRed)
        }
        else {
            icon.renderingMode(.template).vibrant(opacity: 2)
        }
    }

    
}
