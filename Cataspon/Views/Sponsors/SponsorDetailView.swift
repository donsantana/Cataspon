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
    @State var isShowingPromotionAlert = false
    private let promotions = ["promotionBanner", "promotionBanner1"]
    var body: some View {
        VStack(spacing: 25) {
            TopView(titleView: "Sponsor Information")
            Image(uiImage: UIImage(named: sponsor.contactInformation.logoURL)!)
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
            Text(sponsor.description).padding(.all, 10)
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
            ScrollView {
                Text("Promotions").font(.headline).foregroundStyle(.green)
                VStack {
                    ForEach(promotions, id: \.self) { promotion in
                        Image(uiImage: UIImage(named: promotion)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Responsive.shared.widthFloatPercent(percent: 100),height:  Responsive.shared.widthFloatPercent(percent: 45))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .onTapGesture {
                                showPromotionAlert()
                            }
                            .alert(isPresented: $isShowingPromotionAlert) {
                                Alert(title: Text("Promotion Approved"), message: Text("You are approved for this promotion"), dismissButton: .default(Text("Accept")))
                            }
                    }
                }
            }.background(.thinMaterial)
        }
    }
    
    internal func showPromotionAlert() {
        isShowingPromotionAlert = true
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
    SponsorDetailView(sponsor: Sponsor.sampleSponsor)
}
