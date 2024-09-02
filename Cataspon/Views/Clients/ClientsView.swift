//
//  ClientsView.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import SwiftUI

struct ClientsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var clientList: [Client] = Client.allMockClients
    @State private var showingSponsorView = false
    @ObservedObject var clientSelected = ClientSelected()
    
    var body: some View {
        //TopView(titleView: "Influencers")
        //Divider()
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Responsive.shared.widthFloatPercent(percent: 48)))]) {
                    ForEach(searchResults.indices, id: \.self) { index in
                        CardView(client: searchResults[index])
                            .fullScreenCover(isPresented: $showingSponsorView, content: {
                                SponsorsView()//client: clientList[index]
                            })
                            .aspectRatio(5/4, contentMode: .fit)
                            .onTapGesture {
                                clientSelected.client = searchResults[index]
                                moveToSponsorsView()
                            }
                    }
                    .padding(.trailing, 10)
                    .padding(.top, 10)
                    .padding(.leading, 10)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark") {
                        dismiss()
                    }//.foregroundColor(.black)
                }
            }
            .navigationTitle("Influencers")
        }
        .environmentObject(clientSelected)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Type the name")
        /// Search empty state
        .overlay {
            if !searchText.isEmpty && searchResults.isEmpty {
                ContentUnavailableView(
                    "Product not available",
                    systemImage: "magnifyingglass",
                    description: Text("No results for \(searchText) as Influencer")
                )
            }
        }
        .onAppear {
//            APIService.shared.getClients(url: "") { result in
//                switch result {
//                case .success(let clients):
//                    clientList = clients
//                case .failure(let error):
//                    showAlert(error)
//                }
//            }
        }
    }
    
    var searchResults: [Client] {
        return searchText.isEmpty ? clientList : clientList.filter{ $0.name.contains(searchText)}
    }
    
    func moveToSponsorsView() {
        showingSponsorView = true
    }
    
    func showAlert(_ error: APIError) {
        
    }
       
}

#Preview {
    ClientsView()
}

struct CardView: View {
    let client: Client
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                //base.fill(Color(.kidenvDarkBlue)).opacity(isSelected ? 0 : 1)
                base.strokeBorder(.gray,lineWidth: 2)
                VStack {
                    Image(uiImage: UIImage(named: client.contactInformation.logoURL)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Responsive.shared.widthFloatPercent(percent: 40),height:  Responsive.shared.widthFloatPercent(percent: 20))
                    Text(client.name).font(.footnote)
                }
                
            }
        }
    }
}

class ClientSelected: ObservableObject {
    @Published var client: Client?
}


