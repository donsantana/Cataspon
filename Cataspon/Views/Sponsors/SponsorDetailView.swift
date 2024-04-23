//
//  SponsorDetailView.swift
//  Cataspon
//
//  Created by Done Santana on 4/13/24.
//

import SwiftUI

struct SponsorDetailView: View {
    var sponsor: Sponsor
    @State var isShowingCallAlert = false
    @State var isShowingEmailAlert = false
    var body: some View {
        VStack(spacing: 25) {
            TopView(titleView: "Sponsor Information")
            Image(uiImage: UIImage(named: sponsor.contactInformation.logoUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Responsive.shared.widthFloatPercent(percent: 40),height:  Responsive.shared.widthFloatPercent(percent: 20))
//            AsyncImage(url: URL(string: sponsor.contactInformation.logoUrl)) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//            } placeholder: {
//                Image(.defaultLogo)
//            }            
//            AsyncImage(url: URL(string: sponsor.contactInformation.logoUrl)) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//            } placeholder: {
//                Image(.defaultLogo)
//            }
            Text(sponsor.name)
                .font(.title)
            Text(sponsor.description)
            Button(sponsor.contactInformation.phoneNumber) {
                //TODO: Implement the call
                callNumber(number: sponsor.contactInformation.phoneNumber)
            }
            .alert(isPresented: $isShowingCallAlert) {
                Alert(title: Text("Phone Call"), message: Text("This device is unavailable to make the phone call."), dismissButton: .cancel())
            }
            Button(sponsor.contactInformation.email) {
                //TODO: Implement the call
                sendEmail(sponsorEmail: sponsor.contactInformation.email)
            }
            .alert(isPresented: $isShowingEmailAlert) {
                Alert(title: Text("Email"), message: Text("This device is unavailable to send emails."), dismissButton: .cancel())
            }
            Spacer()
        }
    }
    
    func callNumber(number: String) {
        if let phoneCallURL = URL(string: "tel://+\(number)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                isShowingCallAlert = true
            }
        }
    }
    
    func sendEmail(sponsorEmail: String) {
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
}

#Preview {
    SponsorDetailView(sponsor: Sponsor(id: "1", name: "Sponsor One", description: "Sponsor ActivityDescription", contactInformation: ContactInformation(email: "sponsor@test.com", phoneNumber: "7864475555", webUrl: "url", logoUrl: "logoUrl")))
}
