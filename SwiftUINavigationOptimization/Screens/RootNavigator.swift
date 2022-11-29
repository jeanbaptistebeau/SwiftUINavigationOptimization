//
//  RootNavigator.swift
//  SwiftUINavigationOptimization
//
//  Created by Jean-Baptiste Beau on 29/11/2022.
//

import SwiftUI

struct RootNavigator: View {
    // children expect to have a parent navigator; this is just to avoid crashes, it isn't actually used
    @StateObject private var navigator = Navigator(dismiss: {})

    var body: some View {
        PopupContainer {
            ZStack {
                Screen(dismiss: {}) { SettingsScreen() }
            }
        }
        .environmentObject(navigator)
    }
    
}
