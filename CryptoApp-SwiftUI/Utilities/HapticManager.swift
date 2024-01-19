//
//  HapticManager.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 19.01.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
