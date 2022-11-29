//
//  ModalType.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 21/11/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

enum ModalType: Hashable {
    case someModal
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .someModal:
            ModalScreen()
            
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .someModal:
            hasher.combine("someModal")
        }
    }
    
    static func == (lhs: ModalType, rhs: ModalType) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
