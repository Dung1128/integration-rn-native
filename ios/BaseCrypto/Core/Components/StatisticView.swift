//
//  StatisticView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 11/11/24.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 5, content: {
                Image(systemName: "triangle.fill")
                    .rotationEffect(
                        Angle(degrees:(stat.percentagetChange ?? 0) >= 0 ? 0 : 180 )
                    )
                Text(stat.percentagetChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            })
            .foregroundColor((stat.percentagetChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentagetChange == nil ? 0.0 : 1.0)
        })
    }
}


struct StatisticView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat1).previewLayout(.sizeThatFits)
            StatisticView(stat: dev.stat2).previewLayout(.sizeThatFits)
            StatisticView(stat: dev.stat3).previewLayout(.sizeThatFits)
        }
    }
}
