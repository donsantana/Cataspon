//
//  TopView.swift
//  Cataspon
//
//  Created by Done Santana on 4/14/24.
//

import SwiftUI

struct TopView: View {
    @Environment(\.dismiss) private var dismiss
    var titleView: String = ""
    var showCloseBtn = true
    var body: some View {
        HStack {
            Spacer()
            Text(titleView)
                .font(.headline)
            Spacer()
            Button("", systemImage: "xmark") {
                dismiss()
            }.foregroundColor(.black)
                .opacity(showCloseBtn ? 1 : 0)
        }.padding(.trailing, 20)
            .padding(.bottom, 20)
    }
}

#Preview {
    TopView(titleView: "Title View")
}
