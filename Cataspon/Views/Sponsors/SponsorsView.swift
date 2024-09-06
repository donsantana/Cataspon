//
//  SponsorsView.swift
//  Cataspon
//
//  Created by Done Santana on 4/12/24.
//

import SwiftUI

struct SponsorsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var sponsorsList: [Sponsor] = Sponsor.allMockSponsors
    @State var showingSponsorDetail = false
    @State var showAddSponsorView = false
    @EnvironmentObject var clientSelected: ClientSelected
    @EnvironmentObject var userLoggedType: UserLogged
    
    var body: some View {
        var sponsorSelected: Sponsor?
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack() {
                        Image(uiImage: UIImage(named: (clientSelected.client?.contactInformation.logoURL)!)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Responsive.shared.widthFloatPercent(percent: 10),height:  Responsive.shared.widthFloatPercent(percent: 10))
                        Text(clientSelected.client?.name ?? "No name found").font(.headline).padding(.leading, 10)
                        Spacer()
                        Button("", systemImage: "plus") {
                            showAddSponsorView = true
                        }.fullScreenCover(isPresented: $showAddSponsorView) {
                            AddSponsorView()
                        }
                        .opacity(userLoggedType.userType == .influencer ? 1 : 0)
                        .transaction { transaction in
                            transaction.disablesAnimations = true
                        }
                    }
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: Responsive.shared.widthFloatPercent(percent: 70)))]) {
                        ForEach(searchResults.indices, id: \.self) { index in
                            SponsorCardView(sponsor: searchResults[index]).aspectRatio(3/1, contentMode: .fit)
                                .fullScreenCover(isPresented: $showingSponsorDetail, content: {
                                    if let sponsorSelected = sponsorSelected {
                                        SponsorDetailView(sponsor: sponsorSelected)
                                    }
                                })
                                .onTapGesture {
                                    showingSponsorDetail = true
                                    sponsorSelected = searchResults[index]
                                }
                                .transaction { transaction in
                                    transaction.disablesAnimations = true
                                }
                        }
                        .padding(.trailing, 10)
                        .padding(.top, 5)
                    }
                } .padding(.leading, 10)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark") {
                        dismiss()
                    }.tint(.black)
                }
            }
            .navigationTitle("\(userLoggedType.userType == .influencer ? "My " : "")Sponsors")
            .overlay {
                if !searchText.isEmpty && searchResults.isEmpty {
                    ContentUnavailableView(
                        "Product not available",
                        systemImage: "magnifyingglass",
                        description: Text("No results for \(searchText) as Sponsor")
                    )
                }
            }
            .task {
                if let client = clientSelected.client {
                    sponsorsList = client.getSponsors()
                }
            }
            .onAppear {
                //            APIService.shared.getSponsors(url: "",clientID: clientSelected.client?.name ?? "") { result in
                //                switch result {
                //                case .success(let sponsors):
                //                    sponsorsList = sponsors
                //                case .failure(let error):
                //                    showAlert(error)
                //                }
                //            }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
    
    var searchResults: [Sponsor] {
        return searchText.isEmpty ? sponsorsList : sponsorsList.filter{ $0.name.contains(searchText)}
    }
    
    func addNewSponsor() {
        
    }
    
    func showAlert(_ error: APIError) {
        
    }
}

#Preview {
    SponsorsView()
}

struct SponsorCardView: View {
    let sponsor: Sponsor
    @State var isSelected = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.thinMaterial).opacity(0.4)
                base.strokeBorder(.gray,lineWidth: 2)
                HStack(spacing: 10) {
                    Image(uiImage: UIImage(named: sponsor.contactInformation.logoURL)!)
                        .resizable()
                        .frame(width: Responsive.shared.widthFloatPercent(percent: 20), height: Responsive.shared.widthFloatPercent(percent: 20))
                        .padding(.leading, 10)
                    VStack(alignment: .leading) {
                        Text(sponsor.name).font(.headline)
                        Text(sponsor.description).font(.subheadline).opacity(0.5)
                    }
                }
            }
        }
        
    }
}
