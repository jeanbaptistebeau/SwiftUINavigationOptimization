//
//  FullScreenPopup.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 29/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct Popup: View {
    var title: String
    var subtitle: String
    var rows: [PopupButtonData]
    var dismiss: () -> ()
    
    
    // MARK: - Views

    var body: some View {
        ZStack {
            BlurView(style: .dark)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 60) {
                header
                buttons
            }
        }
    }
    
    var header: some View {
        VStack(spacing: 16) {
            Text(title)
                .textStyle(size: .h3, weight: .bold)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .textStyle(size: .normal, weight: .regular, color: .white60)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 30)
    }
    
    var buttons: some View {
        VStack(spacing: 12) {
            ForEach(rows, id: \.title) { button in
                OTextButton(action: { dismissAndPerform(action: button.action) }, text: button.title)
                    .foreground(color: button.titleColor)
                    .background(style: button.backgroundFill)
                    .size(width: .fixed, height: .big)
            }
        }
    }
    
        
    // MARK: - Functions

    private func dismissAndPerform(action: () -> Void) {
        dismiss()
        action()
    }
    
}
