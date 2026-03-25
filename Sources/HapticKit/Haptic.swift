#if canImport(UIKit)
import UIKit

// MARK: - Haptic

/// A clean, static API for triggering haptic feedback on iOS.
///
/// Replaces the verbose `UIFeedbackGenerator` family with simple one-liners.
///
/// ## Impact
/// ```swift
/// Haptic.impact()           // medium (default)
/// Haptic.impact(.light)
/// Haptic.impact(.heavy)
/// ```
///
/// ## Notification
/// ```swift
/// Haptic.success()
/// Haptic.warning()
/// Haptic.error()
/// ```
///
/// ## Selection
/// ```swift
/// Haptic.selection()        // great for pickers and sliders
/// ```
///
/// ## Custom intensity
/// ```swift
/// Haptic.custom(intensity: 0.75)  // 0.0 – 1.0
/// ```
///
/// ## Sequences
/// ```swift
/// Haptic.sequence([.impact(.light), .impact(.heavy)], delay: 0.1)
/// ```
@MainActor
public enum Haptic {

    // MARK: - Impact

    /// Triggers an impact haptic with the given style.
    ///
    /// - Parameter style: The intensity. Defaults to `.medium`.
    public static func impact(_ style: HapticImpactStyle = .medium) {
        guard isHapticsAvailable else { return }
        UIImpactFeedbackGenerator(style: style.uiStyle).impactOccurred()
    }

    // MARK: - Notification

    /// Triggers a success notification haptic. ✅
    public static func success() {
        notify(.success)
    }

    /// Triggers a warning notification haptic. ⚠️
    public static func warning() {
        notify(.warning)
    }

    /// Triggers an error notification haptic. ❌
    public static func error() {
        notify(.error)
    }

    /// Triggers a notification haptic with the given style.
    public static func notify(_ style: HapticNotificationStyle) {
        guard isHapticsAvailable else { return }
        UINotificationFeedbackGenerator().notificationOccurred(style.uiType)
    }

    // MARK: - Selection

    /// Triggers a selection-changed haptic.
    ///
    /// Best for pickers, toggles, and tab bar selections.
    public static func selection() {
        guard isHapticsAvailable else { return }
        UISelectionFeedbackGenerator().selectionChanged()
    }

    // MARK: - Custom Intensity

    /// Triggers an impact haptic at a specific intensity.
    ///
    /// - Parameter intensity: A value between `0.0` (lightest) and `1.0` (strongest).
    public static func custom(intensity: CGFloat) {
        guard isHapticsAvailable else { return }
        let clamped = max(0.0, min(1.0, intensity))
        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: clamped)
    }

    // MARK: - Sequence

    /// Plays a sequence of haptic events with a delay between each.
    ///
    /// ```swift
    /// Haptic.sequence([.impact(.light), .impact(.heavy), .success], delay: 0.12)
    /// ```
    ///
    /// - Parameters:
    ///   - events: The ordered list of haptic events to trigger.
    ///   - delay: Seconds between each event. Defaults to `0.1`.
    public static func sequence(_ events: [HapticEvent], delay: TimeInterval = 0.1) {
        guard isHapticsAvailable else { return }
        for (index, event) in events.enumerated() {
            let time = delay * Double(index)
            if time == 0 {
                event.trigger()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    event.trigger()
                }
            }
        }
    }

    // MARK: - Private

    private static var isHapticsAvailable: Bool {
        UIDevice.current.userInterfaceIdiom == .phone ||
        UIDevice.current.userInterfaceIdiom == .pad
    }
}

// MARK: - HapticEvent

/// A single haptic event used in a ``Haptic/sequence(_:delay:)``.
///
/// ```swift
/// Haptic.sequence([
///     .impact(.light),
///     .impact(.medium),
///     .impact(.heavy),
///     .success
/// ], delay: 0.08)
/// ```
@MainActor
public enum HapticEvent: Sendable {
    case impact(HapticImpactStyle = .medium)
    case success
    case warning
    case error
    case selection
    case custom(intensity: CGFloat)

    func trigger() {
        switch self {
        case .impact(let style):      Haptic.impact(style)
        case .success:                Haptic.success()
        case .warning:                Haptic.warning()
        case .error:                  Haptic.error()
        case .selection:              Haptic.selection()
        case .custom(let intensity):  Haptic.custom(intensity: intensity)
        }
    }
}
#endif
