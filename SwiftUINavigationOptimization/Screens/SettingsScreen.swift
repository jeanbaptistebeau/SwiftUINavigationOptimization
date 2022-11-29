//
//  SettingsScreen.swift
//  Capture
//
//  Created by Jean-Baptiste Beau on 05/07/2022.
//  Copyright © 2022 Sublime. All rights reserved.
//

import SwiftUI

struct SettingsScreen: View {
    enum PushType: Hashable {
        case account(user: User)
    }
    
    @EnvironmentObject private var navigator: Navigator
    
    
    // MARK: - Views
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                title
                
                VStack(spacing: 20) {
                    rows
                }
            }
            .padding(.top, Spaces.tabTopInset)
            .padding(.bottom, Spaces.tabBottomInset)
            .padding(.horizontal, Spaces.with_border)
        }
        .push { (push: PushType) in
            Group {
                switch push {
                case .account(let user):
                    AccountSettingsScreen(user: user)
                }
            }
            .transition(.modal(direction: .right))
        }
    }

    var title: some View {
        Text("Settings")
            .textStyle(size: .h1, weight: .bold)
    }
    
    @ViewBuilder
    var rows: some View {
        SettingsButtonGroup {
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
        }
                
        SettingsButtonGroup {
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
            
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
            
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
        }
        
        SettingsButtonGroup {
            
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
            
            SettingsButton(action: { navigator.push = PushType.account(user: User(name: "name", subtitle: "subtitle")) },
                           title: "Action",
                           icon: Image("star"))
        }
    }
    
}


struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        Preview(type: .screen) {
            SettingsScreen()
        }
    }
}
