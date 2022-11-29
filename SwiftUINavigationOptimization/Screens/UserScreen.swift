//
//  UserScreen.swift
//  SwiftUINavigationOptimization
//
//  Created by Jean-Baptiste Beau on 29/11/2022.
//

import SwiftUI

struct UserScreen: View {
    @EnvironmentObject private var navigator: Navigator
    
    var user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack {
                OIconButton.navigation(.back, foregroundColor: .white, backgroundStyle: .transparent, action: navigator.dismiss)
                Spacer()
            }
            
            Image("fakeImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            Text(user.name)
                .textStyle(size: .h3, weight: .bold)
                .multilineTextAlignment(.leading)
            
            Text(user.subtitle)
                .textStyle(size: .normal, weight: .regular, color: .white30)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 40)
        .padding(.horizontal, Spaces.with_border)
        .clipped()
    }
}

struct UserScreen_Previews: PreviewProvider {
    static var previews: some View {
        Preview(type: .screen) {
            UserScreen(user: User(name: "sdechelle0", subtitle: "sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst"))
        }
    }
}
