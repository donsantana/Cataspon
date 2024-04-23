//
//  AddSponsor.swift
//  Cataspon
//
//  Created by Done Santana on 4/16/24.
//

import SwiftUI
import PhotosUI

struct AddSponsorView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var webUrl: String = ""
    @State var sponsorItem: PhotosPickerItem?
    @State var sponsorLogo: Image?
    
    var body: some View {
        TopView(titleView: "New Sponsor")
        NavigationView {
            Form {
                Section(header: Text("Sponsor")) {
                    Text("Name:").font(.subheadline)
                    TextField("name", text: $name, prompt: Text("Enter the Sponsor name"))
                }
                
                Section(header: Text("Contact Information")) {
                    Text("Email:").font(.subheadline)
                    TextField("email", text: $email, prompt: Text("Enter the email address"))
                    Text("Phone number:").font(.subheadline)
                    TextField("phone", text: $phoneNumber, prompt: Text("Enter the phone number"))
                        .onChange(of: phoneNumber) {
                            if !phoneNumber.isEmpty {
                                phoneNumber = phoneNumber.formatPhoneNumber()
                            }
                        }
                    Text("WebUrl:").font(.subheadline)
                    TextField("webUrl", text: $webUrl, prompt: Text("Enter the web site url"))
                }
                
                Section(header: Text("Sponsor Logo")) {
                    VStack {
                        PhotosPicker("Select the logo", selection: $sponsorItem, matching: .images)
                        sponsorLogo?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200,height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
//                        Image(uiImage: sponsorLogo ?? UIImage(named: "noImage"))
                    }
                    .onChange(of: sponsorItem) {
                        Task {
                            if let loaded = try await sponsorItem?.loadTransferable(type: Image.self) {
                                sponsorLogo = loaded
                            } else {
                                print("Failed")
                            }
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddSponsorView()
}
