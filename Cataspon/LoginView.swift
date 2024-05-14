//
//  MyApp.swift
//  Cataspon
//
//  Created by Done Santana on 4/24/24.
//

import SwiftUI

//@main
//struct MyApp: App {
//    var body: some Scene {
//        WindowGroup {
//            LoginView()
//        }
//    }
//}

struct LoginView: View {
    @State var isLogged = false
    @ObservedObject var userLogged: UserLogged = UserLogged()
    @ObservedObject var clientSelected: ClientSelected = ClientSelected()
    
    var body: some View {
        VStack(spacing: 25) {
            Button("As Influence") {
                clientSelected.client = Client(id: "1", name: "Influencer One", sponsors: ["1","4","6"], contactInformation: ContactInformation(email: "test@test.com", phoneNumber: "7864475555", webURL: "url", logoURL: "influencer1"))
                moveToInfluencerHub()
            }
            Button("As Guest") {
                moveToGuestHub()
            }
        }.fullScreenCover(isPresented: $isLogged) {
            if userLogged.userType == .guest {
                ClientsView()
            } else {
                SponsorsView()
            }
        }
        .environmentObject(clientSelected)
        .environmentObject(userLogged)
    }
    
    func moveToGuestHub() {
        isLogged = true
        userLogged.userType = .guest
    }
    
    func moveToInfluencerHub() {
        isLogged = true
        userLogged.userType = .influencer
    }
}

#Preview {
    LoginView()
}
