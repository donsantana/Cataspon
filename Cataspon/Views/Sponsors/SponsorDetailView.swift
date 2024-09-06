//
//  SponsorDetailView.swift
//  Cataspon
//
//  Created by Done Santana on 4/13/24.
//

import SwiftUI

struct SponsorDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) var openURL
    var sponsor: Sponsor
    @State var isShowingCallAlert = false
    @State var isShowingEmailAlert = false
    @State var isShowingPromotionAlert = false
    private let promotions = ["promotionBanner", "promotionBanner1"]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 10) {
                        Image(uiImage: UIImage(named: sponsor.contactInformation.logoURL)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Responsive.shared.widthFloatPercent(percent: 30))
                            .clipShape(.rect(cornerRadius: 10))
                        VStack(alignment: .leading) {
                            Text(sponsor.name)
                                .font(.title2).fontWeight(.bold)
                            Text(sponsor.description).font(.system(size: 14)).fontWeight(.light)
                        }
                    }
                    
                    //            AsyncImage(url: URL(string: sponsor.contactInformation.logoUrl)) { image in
                    //                image
                    //                    .resizable()
                    //                    .scaledToFit()
                    //            } placeholder: {
                    //                Image(.defaultLogo)
                    //            }
                }
                Section("Contact Information") {
                    Button {
                        //TODO: Implement the call
                        callNumber(number: sponsor.contactInformation.phoneNumber)
                    } label: {
                        HStack {
                            Image(systemName: "phone")
                            Text(sponsor.contactInformation.phoneNumber)
                                .fontWeight(.regular)
                                .font(.system(size: 14))
                        }
                    }
                    .alert(isPresented: $isShowingCallAlert) {
                        Alert(title: Text("Phone Call"), message: Text("This device is unavailable to make the phone call."), dismissButton: .cancel())
                    }
                    Button {
                        //TODO: Implement the call
                        sendEmail(sponsorEmail: sponsor.contactInformation.email)
                    } label: {
                        HStack {
                            Image(systemName: "mail")
                            Text(sponsor.contactInformation.email)
                                .fontWeight(.regular)
                                .font(.system(size: 14))
                        }
                    }
                    .alert(isPresented: $isShowingEmailAlert) {
                        Alert(title: Text("Email"), message: Text("This device is unavailable to send emails."), dismissButton: .cancel())
                    }
                    Button {
                        //TODO: Implement the call
                        openWebsite(sponsorWeb: sponsor.contactInformation.webURL)
                    } label: {
                        HStack {
                            Image(systemName: "network")
                            Text(sponsor.contactInformation.webURL)
                                .fontWeight(.regular)
                                .font(.system(size: 14))
                        }
                    }
                    .alert(isPresented: $isShowingEmailAlert) {
                        Alert(title: Text("Web"), message: Text("This device is unavailable to open the website."), dismissButton: .cancel())
                    }
                }
                
                Section("Promotions") {
                    VStack {
                        ForEach(promotions, id: \.self) { promotion in
                            Image(uiImage: UIImage(named: promotion)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .onTapGesture {
                                    showPromotionAlert()
                                }
                                .alert(isPresented: $isShowingPromotionAlert) {
                                    Alert(title: Text("Promotion Approved"), message: Text("You are approved for this promotion"), dismissButton: .default(Text("Accept")))
                                }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark") {
                        dismiss()
                    }.tint(.black)
                }
            }
            .navigationTitle("Sponsor")
        }
    }
    
    internal func showPromotionAlert() {
        isShowingPromotionAlert = true
    }
    
    internal func callNumber(number: String) {
        if let phoneCallURL = URL(string: "tel://+\(number)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                isShowingCallAlert = true
            }
        }
    }
    
    internal func sendEmail(sponsorEmail: String) {
        let email = "mailto://"
        let emailformatted = email + email // from MongoDB Atlas
        guard let url = URL(string: emailformatted) else {
            isShowingEmailAlert = true
            return
        }
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(url)) {
            application.open(url, options: [:], completionHandler: nil)
        } else {
            isShowingEmailAlert = true
        }
    }
    
    internal func openWebsite(sponsorWeb: String) {
        guard let webSite = URL(string: sponsorWeb) else {return}
        openURL(webSite)
    }
}

#Preview {
    SponsorDetailView(sponsor: Sponsor.sampleSponsor)
}
