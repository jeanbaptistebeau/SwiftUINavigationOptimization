//
//  ModalScreen.swift
//  SwiftUINavigationOptimization
//
//  Created by Jean-Baptiste Beau on 29/11/2022.
//

import SwiftUI

struct ModalScreen: View {
    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                backButtonRow
                header
                
                Text("Some content")
                    .textStyle(size: .normal, weight: .bold)
            }
            .padding(.top, 10)
            .padding(.bottom, 40)
            .padding(.horizontal, Spaces.with_border)
        }
    }
    
    var backButtonRow: some View {
        HStack {
            OIconButton.navigation(.back, foregroundColor: .white, backgroundStyle: .transparent, action: navigator.dismiss)
            Spacer()
        }
    }

    var header: some View {
        Text("Modal")
            .textStyle(size: .h1, weight: .bold)
    }
}

struct ModalScreen_Previews: PreviewProvider {
    static var previews: some View {
        Preview(type: .screen) {
            ModalScreen()
        }
    }
}
