//
//  FullScreenPopupLogic.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 29/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

class PopupPresenter: ObservableObject {
    @Published var popup: PopupData?
}

struct PopupContainer<Content:View>: View {
    @ViewBuilder var content: () -> Content
    
    @StateObject private var model = PopupPresenter()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content()
                .zIndex(0)
            
            if let popup = model.popup {
                Popup(title: popup.title, subtitle: popup.subtitle, rows: popup.rows, dismiss: { model.popup = nil })
                    .id(popup)
                    .transition(.offset(y: 100).combined(with: AnyTransition.opacity.animation(.easeInOut(duration: 0.3))))
                    .zIndex(1)
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: model.popup)
        .environmentObject(model)
    }
    
}


// MARK: - Data structures

struct PopupData: Hashable {
    var title: String
    var subtitle: String
    var rows: [PopupButtonData]
}

struct PopupButtonData: Hashable {
    enum Style { case white, vibrant, dangerous }
    
    var style: Style
    var title: String
    var action: () -> Void
    
    var backgroundFill: OButtonStyle.BackgroundFill {
        switch style {
        case .white: return .white
        case .vibrant: return .vibrant
        case .dangerous: return .custom(.dangerousRed)
        }
    }
    
    var titleColor: Color {
        switch style {
        case .white: return .black
        case .vibrant, .dangerous: return .white
        }
    }
    
    func hash(into hasher: inout Hasher) { hasher.combine(title) }
    static func == (lhs: PopupButtonData, rhs: PopupButtonData) -> Bool { lhs.title == rhs.title }
}

extension PopupButtonData {
    
    static var cancel: PopupButtonData { PopupButtonData(style: .vibrant, title: "Cancel", action: {}) }
    static var ok: PopupButtonData { PopupButtonData(style: .vibrant, title: "Ok", action: {}) }
    
    static func white(title: String, action: @escaping () -> Void) -> PopupButtonData {
        PopupButtonData(style: .white, title: title, action: action)
    }
    
    static func vibrant(title: String, action: @escaping () -> Void) -> PopupButtonData {
        PopupButtonData(style: .vibrant, title: title, action: action)
    }
    
    static func dangerous(title: String, action: @escaping () -> Void) -> PopupButtonData {
        PopupButtonData(style: .dangerous, title: title, action: action)
    }

}
