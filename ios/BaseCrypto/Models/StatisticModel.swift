//
//  StatisticModel.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 11/11/24.
//

import Foundation


struct StatisticModel: Identifiable {

    let id = UUID().uuidString
    let title: String
    let value: String
    let percentagetChange: Double?
    
    init(title: String, value: String, percentagetChange: Double? = nil){
        self.title = title
        self.value = value
        self.percentagetChange = percentagetChange
        
    }
    
}

let newModel = StatisticModel(title: "", value: "", percentagetChange: nil)
let newModel2 = StatisticModel(title: "", value: "")
