//
//  TabNavigator.swift
//  SwiftUINavigationOptimization
//
//  Created by Jean-Baptiste Beau on 29/11/2022.
//

import SwiftUI

struct TabNavigator: View {
    @EnvironmentObject private var navigator: Navigator
        
    @State private var currentTab: AppTabBarItem = .settings
    
    @State private var tabs: [AppTabBarItem] = []
        
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SettingsScreen()
                    .appTabBarItem(tab: .settings, selection: $currentTab)

                ListScreen()
                    .appTabBarItem(tab: .journal, selection: $currentTab)
                
                ListScreen()
                    .appTabBarItem(tab: .lucidity, selection: $currentTab)

                ListScreen()
                    .appTabBarItem(tab: .statistics, selection: $currentTab)
            }
            
            if navigator.push == nil {
                TabBarView(tabs: tabs, currentTab: $currentTab)
            }
        }
        .ignoresSafeArea(.keyboard, edges: navigator.push == nil ? .all : [])
        .onPreferenceChange(AppTabItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }
    
}


struct AppTabItemModifier: ViewModifier {
    let tab: AppTabBarItem
    @Binding var selection: AppTabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(tab == selection ? 1 : 0)
            .preference(key: AppTabItemPreferenceKey.self, value: [tab])
    }
    
}

extension View {
    func appTabBarItem(tab: AppTabBarItem, selection: Binding<AppTabBarItem>) -> some View {
        modifier(AppTabItemModifier(tab: tab, selection: selection))
    }
}

struct AppTabItemPreferenceKey: PreferenceKey {
    static var defaultValue: [AppTabBarItem] = []
    
    static func reduce(value: inout [AppTabBarItem], nextValue: () -> [AppTabBarItem]) {
        value += nextValue()
    }
    
}

struct TabBarView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let tabs: [AppTabBarItem]
    @Binding var currentTab: AppTabBarItem
    
    // MARK: - Views
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                TabBarButton(image: tab.icon,
                             isSelected: tab == currentTab,
                             showLabel: horizontalSizeClass != .compact,
                             onButtonPressed: { currentTab = tab })
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal, 12)
        .background(
            Color.white.cornerRadius(16, corners: [.topLeft, .topRight]).edgesIgnoringSafeArea(.bottom)
        )
    }
    
}

fileprivate struct TabBarButton: View {
    var image: Image
    var isSelected: Bool
    var showLabel: Bool

    var onButtonPressed: () -> ()
    
    var body: some View {
        Button(action: onButtonPressed) {
            image
                .renderingMode(.template)
                .foregroundColor(isSelected ? .oLightPurple : Color.black.opacity(0.2))
                .textStyle(size: .tiny, weight: .black, color: nil)
        }
        .frame(maxWidth: .infinity)
        .shadow(color: isSelected ? .oLightPurple.opacity(0.4) : .clear, radius: 10, x: 0, y: 0)
    }

}

enum AppTabBarItem: CaseIterable {
    case journal, lucidity, statistics, settings
    
    var icon: Image {
        switch self {
        case .journal: return Image("cancel")
        case .lucidity: return Image("cancel")
        case .statistics: return Image("cancel")
        case .settings: return Image("cancel")
        }
    }
}
