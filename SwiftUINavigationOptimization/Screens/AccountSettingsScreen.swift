//
//  AccountSettingsScreen.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 06/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct AccountSettingsScreen: View {
//    enum PushType: Hashable {
//        case usernameEdition(user: User)
//        case deleteAccount(trueEmail: String)
//    }

    @EnvironmentObject private var navigator: Navigator

    var user: User
    
    @State private var isLoading = false
    
    
    // MARK: - Views
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 12) {
                    backButtonRow
                    title
                }
                
                rows
                rows
                rows
                rows
                rows
                rows
                rows
            }
            .padding(.top, 10)
            .padding(.bottom, 40)
            .padding(.horizontal, Spaces.with_border)
        }
//        .push { (push: PushType) in
//            Group {
//                switch push {
//                case .usernameEdition(let user):
//                    UsernameEditionScreen(user: user)
//                case .deleteAccount(let email):
//                    DeleteAccountScreen(trueEmail: email)
//                }
//            }
//            .transition(.modal(direction: .bottom))
//        }
    }

    var backButtonRow: some View {
        HStack {
            OIconButton.navigation(.back, foregroundColor: .white, backgroundStyle: .transparent, action: navigator.dismiss)
            Spacer()
        }
    }
    
    var title: some View {
        Text("Account")
            .textStyle(size: .h1, weight: .bold)
    }

    var rows: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                SettingsButtonGroup {
                    UserInfoSettingsView(title: user.name, icon: Image("auth_username"))
                    UserInfoSettingsView(title: user.subtitle, icon: Image("auth_email"))
                }
                
                SettingsButton(action: {}, title: "Change password", icon: Image("auth_password"))
                
                SettingsButton(action: {}, title: "Premium", icon: Image("star"))
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Dangerous zone")
                    .textStyle(size: .h4, weight: .bold)
                
                SettingsButtonGroup {
                    SettingsButton(action: {}, title: "Log out", icon: Image("log_out"), isDangerous: true)
                    SettingsButton(action: {}, title: "Delete account", icon: Image("delete_account"), isDangerous: true)
                }
            }
        }
    }

    
}

struct AccountSettingsScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        Preview(type: .screen) {
            AccountSettingsScreen(user: User(name: "username", subtitle: "subtitle"))
        }
    }
}
