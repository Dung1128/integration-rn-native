//
//  PortfolioView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 12/11/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0, content: {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                })
            }
            .navigationTitle("Edit portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                   leftButton
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                   rightButton
                }
            })
            .onChange(of: vm.searchText, perform: { value in
                if value == "" {
                    removeSelectedCoin()
                }
            })
            
            
        }
    }
}

struct PortfolioView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environmentObject(dev.homeVM)
            
            PortfolioView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
                .environmentObject(dev.homeVM)
        }
    }
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10, content: {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
//                                selectedCoin = coin
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( selectedCoin?.id == coin.id ?
                                         Color.theme.green: Color.clear
                                         , lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        )
                }
            })
        })
//        .onTapGesture {
//            UIApplication.shared.endEditing()
//        }
        .padding(.vertical, 4)
//        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .padding(.leading)
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack( spacing: 20, content: {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "") :")
                Spacer()
                Text(selectedCoin?.currentPrice
                    .asCurrencyWith6Decimals() ?? "")
            }
           
            Divider()
            HStack{
                Text("Amount in your portfolio:")
                Spacer()
                TextField("Ex: 1,4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            Divider()
            HStack{
                Text("Current Value: ")
                Spacer()
                Text(getCoinvalue().asCurrencyWith6Decimals())
            }
        })
        .padding()
        .font(.headline)
    }
    
    private var leftButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
    
    private var rightButton: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save")
            })
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func getCoinvalue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
        
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        //save to portfolio
        
        vm.updatePorfolio(coin: coin, amount: amount)
        
        //show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        //hide keyboard
        
        UIApplication.shared.endEditing()
        
        //hide checkmark
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut) {
                showCheckMark = false
            }
        }
       
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
       
    }
}
