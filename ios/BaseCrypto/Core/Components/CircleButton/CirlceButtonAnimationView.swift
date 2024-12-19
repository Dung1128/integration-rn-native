//
//  CirlceButtonAnimationView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 8/11/24.
//

import SwiftUI

struct CirlceButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
//            .animation(Animation.easeOut, value: animate ? 1.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
            .onAppear{
                animate.toggle()
            }
    }
}

#Preview {
    CirlceButtonAnimationView(animate: .constant(false))
}
