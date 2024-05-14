//
//  ClientsView.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import SwiftUI

struct ClientsView: View {
    @State private var clientList: [Client] = Client.allMockClients
    @State private var showingSponsorView = false
    @ObservedObject var clientSelected = ClientSelected()
    
    var body: some View {
        TopView(titleView: "Influencers")
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Responsive.shared.widthFloatPercent(percent: 48)))]) {
                ForEach(clientList.indices, id: \.self) { index in
                    CardView(client: clientList[index])
                        .fullScreenCover(isPresented: $showingSponsorView, content: {
                            SponsorsView()//client: clientList[index]
                        })
                        .aspectRatio(5/4, contentMode: .fit)
                        .onTapGesture {
                            clientSelected.client = clientList[index]
                            moveToSponsorsView()
                        }
                }
                .padding(.trailing, 10)
                .padding(.top, 5)
                .padding(.leading, 10)
            }
        }
        .environmentObject(clientSelected)
        
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


