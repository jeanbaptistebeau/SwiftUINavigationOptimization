//
//  PushModifier.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 28/11/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct PushModifier<T:Hashable,V:View>: ViewModifier {
    @EnvironmentObject private var navigator: Navigator

    @ViewBuilder var block: (T) -> V
    
    var handledPush: T? {
        navigator.push as? T
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .animation(nil, value: navigator.push)
                .opacity(handledPush == nil ? 1 : 0)
            
            Screen(dismiss: { navigator.push = nil }) {
                if let push = handledPush {
                    block(push)
                }
            }
        }
        .animation(.easeOut(duration: 0.3), value: navigator.push)
    }
}

extension View {
    func push<T:Hashable,V:View>(@ViewBuilder block: @escaping (T) -> V) -> some View {
        modifier(PushModifier(block: block))
    }
}
