//
//  UIApplication.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 11/11/24.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
