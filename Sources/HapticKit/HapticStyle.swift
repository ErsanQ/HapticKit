#if canImport(UIKit)
import UIKit

// MARK: - HapticImpactStyle

/// The intensity level for an impact haptic.
///
/// Maps directly to `UIImpactFeedbackGenerator.FeedbackStyle`.
public enum HapticImpactStyle: Sendable {
    /// A soft, subtle tap.
    case light
    /// A medium-strength tap. Good for most interactions.
    case medium
    /// A strong, solid tap.
    case heavy
    /// A crisp, rigid tap.
    case rigid
    /// A soft, rounded tap.
    case soft

    var uiStyle: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .light:  return .light
        case .medium: return .medium
        case .heavy:  return .heavy
        case .rigid:  return .rigid
        case .soft:   return .soft
        }
    }
}

// MARK: - HapticNotificationStyle

/// The type of notification haptic to trigger.
///
/// Maps directly to `UINotificationFeedbackGenerator.FeedbackType`.
public enum HapticNotificationStyle: Sendable {
    /// Indicates a task completed successfully.
    case success
    /// Indicates a warning.
    case warning
    /// Indicates an error occurred.
    case error

    var uiType: UINotificationFeedbackGenerator.FeedbackType {
        switch self {
        case .success: return .success
        case .warning: return .warning
        case .error:   return .error
        }
    }
}
#endif
