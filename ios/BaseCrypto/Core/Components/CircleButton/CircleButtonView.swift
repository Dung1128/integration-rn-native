//
//  CircleButtonView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 8/11/24.
//

import SwiftUI

struct CircleButtonView: View {
    
    let IconName: String
    
    var body: some View {
        Image(systemName: IconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10
            )
            .padding()
    }
}



//#Preview {
//    CircleButtonView(IconName:"info")
//}


struct CircleButtonView_previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(IconName:"info")
            .previewLayout(.sizeThatFits)
            
            
            CircleButtonView(IconName:"info")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        }
    }
}

