//
//  SettingsButtonGroup.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 06/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct SettingsButtonGroup: View {
    
    private let views: [AnyView]
    
    init<Views>(@ViewBuilder content: @escaping () -> TupleView<Views>) {
        views = content().getViews
    }

    // MARK: - Views
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(views.indices, id: \.self) { index in
                views[index]
                    .environment(\.relativeOrder, RelativeOrder(index: index, total: views.count))
                if index < views.count - 1 { separator() }
            }
        }
    }

    func separator() -> some View {
        ZStack {
            VibrantBackgroundView(cornerRadius: 0)
            Capsule()
                .vibrant(opacity: 0.15)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 3)
    }
    
    
    // MARK: - Functions

    
}

enum RelativeOrder {
    case first, middle, last, alone
    
    init(index: Int, total: Int) {
        if total <= 1 { self = .alone }
        else if index == 0 { self = .first }
        else if index == total - 1 { self = .last }
        else { self = .middle }
    }
}

private struct RelativeOrderKey: EnvironmentKey {
    static let defaultValue = RelativeOrder.alone
}

extension EnvironmentValues {
  var relativeOrder: RelativeOrder {
    get { self[RelativeOrderKey.self] }
    set { self[RelativeOrderKey.self] = newValue }
  }
}
