//
//  CoinImageView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 9/11/24.
//

import SwiftUI


struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.loading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

//#Preview {
//    CoinImageView()
//}

struct CoinImageView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            CoinImageView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
//            CoinImageView()
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.light)
        }
    }
}
