//
//  Preview.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 28/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct Preview<V:View>: View {
    enum Structure { case screen, centered, scroll }
    
    var type: Structure
    @ViewBuilder var content: () -> V
    
    // children expect to have a parent navigator; this is just to avoid crashes, it isn't actually used
    @StateObject private var navigator = Navigator(dismiss: {})

    var body: some View {
        ZStack {
            AppBackground()
            PopupContainer {
                Screen(dismiss: {}) {
                    structuredContent.frame(maxHeight: .infinity)
                }
                .environmentObject(navigator)
            }
        }
    }
    
    @ViewBuilder
    var structuredContent: some View {
        switch type {
        case .screen:
            content()
            
        case .centered:
            VStack(spacing: 20) {
                content()
            }
            .padding(.horizontal, 17)
            
        case .scroll:
            ScrollView {
                VStack {
                    content()
                }
                .padding(.horizontal, 17)
            }
            
        }
    }
    
}

struct PreviewState<T, V:View>: View {
    @State private var state: T
    @ViewBuilder var content: (Binding<T>) -> V

    init(initial: T, content: @escaping (Binding<T>) -> V) {
        self._state = State(initialValue: initial)
        self.content = content
    }
    
    var body: some View {
        content($state)
    }
}

struct PreviewStateObject<T:ObservableObject, V:View>: View {
    @StateObject private var stateObject: T
    @ViewBuilder var content: (T) -> V

    init(initial: T, content: @escaping (T) -> V) {
        self._stateObject = StateObject(wrappedValue: initial)
        self.content = content
    }
    
    var body: some View {
        content(stateObject)
    }
}
