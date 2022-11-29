//
//  SwiftUINavigationOptimizationApp.swift
//  SwiftUINavigationOptimization
//
//  Created by Jean-Baptiste Beau on 29/11/2022.
//

import SwiftUI

@main
struct SwiftUINavigationOptimizationApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppBackground()
                RootNavigator()
            }
        }
    }
}
