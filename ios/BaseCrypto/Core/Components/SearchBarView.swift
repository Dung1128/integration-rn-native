//
//  SearchBarView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 11/11/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x :10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        ).padding()
    }
}

//#Preview {
//    SearchBarView()
//}


struct SearchBarView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant("Hello"))
                .previewLayout(.sizeThatFits)
            
            SearchBarView(searchText: .constant("Hello"))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
        }
    }
}
