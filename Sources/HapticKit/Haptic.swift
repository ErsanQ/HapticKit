import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// A high-level manager for triggering haptic feedback across Apple platforms.
///
/// `Haptic` provides a unified API for impact, notification, and selection feedback.
/// It automatically handles platform availability, providing safe fallbacks on 
/// platforms that do not support hardware haptics (like macOS or older devices).
///
/// ## Usage
/// ```swift
/// Haptic.shared.play(.impact(.medium))
/// ```
@MainActor
public final class Haptic: Sendable {
    
    /// The shared singleton instance of `Haptic`.
    public static let shared = Haptic()
    
    private init() {}
    
    /// Plays a specific haptic feedback style.
    ///
    /// - Parameter style: The `HapticStyle` to trigger (e.g., `.impact(.heavy)`).
    public func play(_ style: HapticStyle) {
        #if os(iOS)
        switch style {
        case .impact(let impactStyle):
            let generator = UIImpactFeedbackGenerator(style: impactStyle)
            generator.prepare()
            generator.impactOccurred()
            
        case .notification(let notificationType):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(notificationType)
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
        #endif
    }
}
