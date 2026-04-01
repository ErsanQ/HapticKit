#if canImport(SwiftUI)
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// Defines the variety of haptic feedback patterns supported by the ErsanQ ecosystem.
public enum HapticStyle: Sendable {
    /// A feedback style that indicates a physical impact.
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    /// A feedback style that communicates the outcome of a task (Success, Warning, Error).
    case notification(UINotificationFeedbackGenerator.FeedbackType)
    /// A feedback style used to indicate a change in selection.
    case selection
}

// Extension to provide default styles and ensure compatibility.
public extension HapticStyle {
    #if !os(iOS)
    /// Mock types for non-iOS platforms to ensure compilation.
    enum UIImpactFeedbackGenerator {
        public enum FeedbackStyle: Sendable { case light, medium, heavy, soft, rigid }
    }
    enum UINotificationFeedbackGenerator {
        public enum FeedbackType: Sendable { case success, warning, error }
    }
    #endif
    
    /// A standard light impact.
    static var light: HapticStyle { .impact(.light) }
    /// A standard medium impact.
    static var medium: HapticStyle { .impact(.medium) }
    /// A standard heavy impact.
    static var heavy: HapticStyle { .impact(.heavy) }
    /// A success notification sequence.
    static var success: HapticStyle { .notification(.success) }
    /// An error notification sequence.
    static var error: HapticStyle { .notification(.error) }
}
#endif
