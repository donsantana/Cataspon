//
//  AddSponsor.swift
//  Cataspon
//
//  Created by Done Santana on 4/16/24.
//

import SwiftUI
import PhotosUI

struct AddSponsorView: View {
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var description: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var webUrl: String = ""
    @State var sponsorItem: PhotosPickerItem?
    @State var sponsorLogo: Image?
    @State var showMessage = false
    @State var addSponsorTitle = ""
    @State var addSponsorMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Sponsor")) {
                    Text("Name").font(.subheadline)
                    TextField("name", text: $name, prompt: Text("Enter the Sponsor name"))
                    Text("Business description").font(.subheadline)
                    TextField("description", text: $description, prompt: Text("Enter the Sponsor description"))
                }
                
                Section(header: Text("Contact Information")) {
                    Text("Email").font(.subheadline)
                    TextField("email", text: $email, prompt: Text("Enter the email address"))
                        .keyboardType(.emailAddress).textInputAutocapitalization(.never)
                    Text("Phone number").font(.subheadline)
                    TextField("phone", text: $phoneNumber, prompt: Text("Enter the phone number"))
                        .onChange(of: phoneNumber) {
                            if !phoneNumber.isEmpty {
                                phoneNumber = phoneNumber.formatPhoneNumber()
                            }
                        }
                    Text("WebUrl").font(.subheadline)
                    TextField("webUrl", text: $webUrl, prompt: Text("Enter the web site url")).textInputAutocapitalization(.never)
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
                
                Section {
                    Button {
                        addNewSponsor()
                    } label: {
                        Text("Add Sponsor")
                            .frame(width: UIScreen.main.bounds.width - 40, height: 35)
                            .foregroundStyle(.white)
                    }
                    .background(Color(.systemBlue))
                    .clipShape(.rect(cornerRadius: 10))
                    .alert(isPresented: $showMessage) {
                        Alert(title: Text(addSponsorTitle), message: Text(addSponsorMessage), dismissButton: .default(Text("Acept")))
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark") {
                        dismiss()
                    }
                    .tint(.black)
                }
            }
            .navigationTitle("New sponsor")
        }
        
    }
    
    func addNewSponsor() {
        let newSponsor = Sponsor(id: String(Int.random(in: 0..<1000)), name: name, description: description, contactInformation: ContactInformation(email: email, phoneNumber: phoneNumber, webURL: webUrl, logoURL: "test"))
        var currentSponsors = Sponsor.allMockSponsors
        currentSponsors.append(newSponsor)

        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("sponsors.json")
            
            let encoder = JSONEncoder()
            try encoder.encode(currentSponsors).write(to: fileURL)
            
            addSponsorTitle = "Success"
            addSponsorMessage = "The new sponsor was added successfully"
            showMessage = true
        } catch {
            addSponsorTitle = "Some error"
            addSponsorMessage = error.localizedDescription
            showMessage = true
            print(error.localizedDescription)
        }
    }
    
}

#Preview {
    AddSponsorView()
}
