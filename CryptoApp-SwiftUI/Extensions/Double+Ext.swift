//
//  Double+Ext.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 16.01.2024.
//

import Foundation



extension Double {
    
    /// Convert a double into a currency with 2 decimal places
    /// ```
    ///  Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Convert a double into a currency as a String with 2-6 decimal places
    /// ```
    ///  Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrnecyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    /// Convert a double into a currency with 2-6 decimal places
    /// ```
    ///  Convert 1234.56 to $1,234.56
    ///  Convert 12.3456 to $12.23456
    ///  Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Convert a double into a currency as a String with 2-6 decimal places
    /// ```
    ///  Convert 1234.56 to "$1,234.56"
    ///  Convert 12.3456 to "$12.23456"
    ///  Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrnecyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert a double into string representation
    /// ```
    ///  Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert a double into string representation with percent symbol
    /// ```
    ///  Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
