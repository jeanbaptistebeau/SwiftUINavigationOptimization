//
//  SheetContainer.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 22/10/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

class SheetPresenter: ObservableObject {
    @Published var sheetType: SheetType?
}

struct SheetContainer<Content:View>: View {
    @ObservedObject var navigator: Navigator

    @ViewBuilder var content: () -> Content
        
    var body: some View {
        ZStack(alignment: .bottom) {
            screen.zIndex(0)
            
            if let type = navigator.sheet {
                sheet(type: type)
                    .transition(.move(edge: .bottom).combined(with: .offset(y: 100))) // had to use offset to account for safe area. I couldn't find a way to make it work otherwise.
                    .zIndex(1)
            }
        }
        // TODO: animation bug at the bottom at the end of dismissing animation
        // TODO: ok button bug (conflict with default animation, see with using custom button style)
        // TODO: bug with flexible layout views
//        .animation(.linear(duration: 4), value: model.sheetType?.id)
//        .animation(.spring(response: 1, dampingFraction: 0.3), value: model.sheetType?.id)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: navigator.sheet?.id)
    }
    
    var screen: some View {
        content()
//            .allowsHitTesting(navigator.sheet == nil)
//            .animation(nil, value: navigator.sheet?.id)
//            .opacity(navigator.sheet == nil ? 1 : 0.6)
//            .animation(.linear(duration: 0.2), value: navigator.sheet?.id)
    }

    
    @ViewBuilder
    func sheet(type: SheetType) -> some View {
        if let data = type as? DateSheetType {
            DatePickerSheet(initial: data.initial, type: data.type, customTitle: data.customTitle, completion: data.completion).id(data.id)
        }
        // [...]
    }
    
}

