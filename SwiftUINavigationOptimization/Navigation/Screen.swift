//
//  Screen.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 21/11/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct Screen<Content:View>: View {
    @EnvironmentObject private var popupPresenter: PopupPresenter
    @EnvironmentObject private var parentNavigator: Navigator
    
    @ViewBuilder var content: () -> Content
    
    @StateObject private var navigator: Navigator
    
    init(dismiss: @escaping () -> (), @ViewBuilder content: @escaping () -> Content) {
        self._navigator = StateObject(wrappedValue: Navigator(dismiss: dismiss))
        self.content = content
    }
    
    var body: some View {
        ModalContainer(navigator: navigator) {
            SheetContainer(navigator: navigator) {
                content()
            }
        }
        .environmentObject(navigator)
        .onAppear {
            navigator.popupPresenter = popupPresenter
            navigator.parent = parentNavigator
        }
    }
    
}

