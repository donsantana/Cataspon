//
//  ListElementsView.swift
//  Cataspon
//
//  Created by Done Santana on 4/12/24.
//

import SwiftUI

protocol ElementListable {
    
}

//struct ListElementsView<T: ElementListable>: View {
//    @State var elementsList: [T] = []
//
//    var body: some View {
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: Responsive.shared.widthFloatPercent(percent: 45)))]) {
//            ForEach(elementsList.indices, id: \.self) { index in
//                CardView(client: elementsList[index]).aspectRatio(5/4, contentMode: .fit)
//            }
//            .padding(.trailing, 20)
//            .padding(.top, 5)
//            .padding(.leading, 20)
//        }
//    }
//}
//
//#Preview {
//    ListElementsView()
//}

//struct CardView<T:ElementListable>: View {
//    let client: Client
//    @State var isSelected = false
//    
//    var body: some View {
//        ZStack {
//            let base = RoundedRectangle(cornerRadius: 12)
//            Group {
//                //base.fill(Color(.kidenvDarkBlue)).opacity(isSelected ? 0 : 1)
//                base.strokeBorder(.gray,lineWidth: 2)
//                Text(client.name).font(.footnote)
//            }
//            .opacity(isSelected ? 1 : 1)
//        }
//        .onTapGesture {
//            isSelected = !isSelected
//        }
//    }
//}
