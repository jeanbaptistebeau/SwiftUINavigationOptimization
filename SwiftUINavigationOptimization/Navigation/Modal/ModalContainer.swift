//
//  ModalScreen.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 07/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI
import UIKit

struct ModalContainer<Content:View>: View {
    @ObservedObject var navigator: Navigator

    @ViewBuilder var content: () -> Content
        
    var body: some View {
        ZStack(alignment: .bottom) {
            content()
                .animation(nil, value: navigator.modal)
                .opacity(navigator.modal == nil ? 1 : 0)
            
            if let type = navigator.modal {
                Screen(dismiss: { navigator.modal = nil }) {
                    type.view().id(type)
                }
                .transition(.modal(direction: .bottom))
            }
        }
        .animation(.easeOut(duration: 0.3), value: navigator.modal)
    }
}


// MARK: - Transitions

enum TransitionDirection {
    case bottom, right
    
    var edge: Edge {
        switch self {
        case .bottom: return .bottom
        case .right: return .trailing
        }
    }
}

struct ModalTransitionModifier: ViewModifier {
    var direction: TransitionDirection
    var x: CGFloat

    func body(content: Content) -> some View {
        content
            .opacity(1 - x)
            .offset(x: (direction == .right ? 200 : 0) * x,
                    y: (direction == .bottom ? 300 : 0) * x)
    }
}

extension AnyTransition {
    
    static func modal(direction: TransitionDirection) -> AnyTransition {
        modifier(
            active: ModalTransitionModifier(direction: direction, x: 1),
            identity: ModalTransitionModifier(direction: direction, x: 0)
        )
    }
    
}
