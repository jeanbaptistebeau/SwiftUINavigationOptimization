//
//  ModalBottomView.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 20/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct Sheet<Content:View>: View {
    @EnvironmentObject private var navigator: Navigator
    
    var title: String
    var canCancel: Bool
    var onSave: (() -> ())?
    var help: String?
    
    @ViewBuilder var content: () -> Content

    @State private var helpIsOpen = false
    
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 16) {
            navButtons
            titleRow
            
            if let help = help, helpIsOpen { helpView(help: help) }
            else { content() }
        }
        .padding(.horizontal, 23)
        .padding(.top, 23)
        .frame(maxWidth: .infinity)
        .background(
            BlurView(style: .dark)
                .edgesIgnoringSafeArea([.bottom])
                .overlay(Color.veryDarkBlue.opacity(0.5))
                .cornerRadius(32, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.bottom)
        )
        .overlay(
            Capsule()
                .fill(.white.opacity(0.05))
                .frame(width: 50, height: 5)
                .offset(y: 16)
            , alignment: .top
        )
        .ignoresSafeArea(.container, edges: .bottom) // allows safe area for keyboard
    }
    
    var navButtons: some View {
        HStack {
            if canCancel {
                OIconButton(action: cancelWasPressed,
                            icon: Image("small_cross"),
                            size: 46,
                            foregroundColor: .white30,
                            backgroundFill: .vibrantCustom(1))
            }
            
            Spacer()
            
            if onSave != nil {
                OTextButton(action: okWasPressed, text: "OK")
                    .foreground(color: .black)
                    .background(shape: .capsule, style: .white)
                    .size(height: .small)
                    .inset(horizontal: 30)
            }
        }
    }
    
    var titleRow: some View {
        HStack {
            Text(title)
                .textStyle(size: .h2, weight: .bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            if help != nil {
                OIconButton(action: { helpIsOpen.toggle() },
                            icon: Image("info"),
                            size: 36,
                            foregroundColor: helpIsOpen ? .black : .white30,
                            backgroundFill: helpIsOpen ? .white : .vibrant)
            }
        }
    }
    
    func helpView(help: String) -> some View {
        Text(help)
            .textStyle(size: .normal, weight: .regular, color: .white60)
            .lineSpacing(5)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
    }
    
    
    // MARK: - Functions
    
    private func cancelWasPressed() {
        navigator.sheet = nil
    }
    
    private func okWasPressed() {
        navigator.sheet = nil
        onSave?()
    }

    
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Capsule().fill(.orange))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.4), value: configuration.isPressed)
    }
}


struct ModalBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AppBackground()
            VStack(spacing: 5) {
                ForEach(1...20, id: \.self) { _ in
                    Text("Some Content")
                        .textStyle(size: .normal, weight: .bold)
                    Rectangle().fill(.white.opacity(0.5)).frame(height: 3)
                }
            }
            .opacity(0.1)
            Sheet(title: "Title of the modal", canCancel: false, onSave: {}) {
                Rectangle().fill(.white).frame(height: 300)
            }
        }
    }
}
