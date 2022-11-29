//
//  ContentView.swift
//  SwiftUINavigationOptimization
//
//  Created by Jean-Baptiste Beau on 29/11/2022.
//

import SwiftUI

struct ListScreen: View {
    enum PushType: Hashable {
        case userView(user: User)
    }

    @EnvironmentObject private var navigator: Navigator
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    OTextButton(action: presentModal, text: "Modal")
                        .foreground(size: .small, weight: .regular, color: .white)
                        .inset(horizontal: 20)
                    OTextButton(action: presentSheet, text: "Sheet")
                        .foreground(size: .small, weight: .regular, color: .white)
                        .inset(horizontal: 20)
                    OTextButton(action: presentPopup, text: "Popup")
                        .foreground(size: .small, weight: .regular, color: .white)
                        .inset(horizontal: 20)
                }
                .padding(.vertical, 40)

                ForEach(users, id: \.self) { user in
                    Button(action: { navigator.push = PushType.userView(user: user) }) {
                        VStack {
                            HStack {
                                Image("fakeImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 200)
                                    .clipped()
                                
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                        .textStyle(size: .h3, weight: .bold)
                                        .multilineTextAlignment(.leading)
                                    Text(user.subtitle)
                                        .textStyle(size: .normal, weight: .regular, color: .white30)
                                        .multilineTextAlignment(.leading)
                                }
                                
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.1))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .push { (push: PushType) in
            switch push {
            case .userView(let user):
                UserScreen(user: user)
                    .transition(.move(edge: .trailing))
            }
        }
    }

    var popup: PopupData {
        PopupData(title: "This is a popup", subtitle: "Something went wrong, please try again later.", rows: [
            .ok
        ])
    }
    
    func presentModal() {
        navigator.modal = .someModal
    }
    
    func presentSheet() {
        navigator.sheet = DateSheetType(initial: Date(), type: .date, completion: { _ in })
    }

    func presentPopup() {
        navigator.popup = popup
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(type: .screen) {
            ListScreen()
        }
    }
}
