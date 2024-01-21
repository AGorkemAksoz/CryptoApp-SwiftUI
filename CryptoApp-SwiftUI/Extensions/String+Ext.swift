//
//  String+Ext.swift
//  CryptoApp-SwiftUI
//
//  Created by Ali Görkem Aksöz on 21.01.2024.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil )
    }
}
