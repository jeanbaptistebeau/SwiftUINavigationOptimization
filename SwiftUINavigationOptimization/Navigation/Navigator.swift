//
//  Navigator.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 28/11/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

class Navigator: ObservableObject {
    @Published var modal: ModalType?
    
    @Published var sheet: SheetType?
    
    @Published var push: AnyHashable?
    
    var popup: PopupData? {
        get { popupPresenter?.popup }
        set {
            popupPresenter?.popup = newValue
        }
    }
    
    var popupPresenter: PopupPresenter?
    var parent: Navigator?
    var dismiss: () -> ()

    init(dismiss: @escaping () -> ()) {
        self.dismiss = dismiss
    }
}
