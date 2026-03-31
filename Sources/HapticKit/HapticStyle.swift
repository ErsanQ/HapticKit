import Foundation

#if canImport(UIKit)
import UIKit
#endif

// MARK: - HapticImpactStyle

/// The intensity level for an impact haptic.
public enum HapticImpactStyle: Sendable {
    case light
    case medium
    case heavy
    case rigid
    case soft

    #if canImport(UIKit)
    var uiStyle: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .light:  return .light
        case .medium: return .medium
        case .heavy:  return .heavy
        case .rigid:  return .rigid
        case .soft:   return .soft
        }
    }
    #endif
}

// MARK: - HapticNotificationStyle

/// The type of notification haptic to trigger.
public enum HapticNotificationStyle: Sendable {
    case success
    case warning
    case error

    #if canImport(UIKit)
    var uiType: UINotificationFeedbackGenerator.FeedbackType {
        switch self {
        case .success: return .success
        case .warning: return .warning
        case .error:   return .error
        }
    }
    #endif
}
