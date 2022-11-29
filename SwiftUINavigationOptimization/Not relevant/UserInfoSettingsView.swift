//
//  UserInfoSettingsView.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 08/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct UserInfoSettingsView: View {
    @Environment(\.relativeOrder) var relativeOrder
    
    var title: String
    var subtitle: String? = nil
    var icon: Image
    var titleIsDiscrete: Bool = false
    var editionCallback: (() -> Void)? = nil

    var roundedCorners: UIRectCorner {
        switch relativeOrder {
        case .first: return [.topLeft, .topRight]
        case .middle: return []
        case .last: return [.bottomLeft, .bottomRight]
        case .alone: return .allCorners
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            icon.renderingMode(.template).vibrant(opacity: 2)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .textStyle(size: .normal, weight: .semiBold, color: titleIsDiscrete ? .white30 : .white)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .textStyle(size: .normal, weight: .semiBold, color: .white30)
                }
            }
                            
            Spacer()
            
            OIconButton(action: { editionCallback?() },
                        icon: Image("pencil"),
                        size: 42,
                        foregroundColor: .white,
                        backgroundFill: .vibrant)
            .opacity(editionCallback == nil ? 0 : 1)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .vibrantBackground(cornerRadius: 0)
        .cornerRadius(16, corners: roundedCorners)
    }
}
