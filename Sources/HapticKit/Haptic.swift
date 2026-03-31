import Foundation

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Haptic

/// A clean, static API for triggering haptic feedback on iOS.
@MainActor
public enum Haptic {

    // MARK: - Impact

    /// Triggers an impact haptic with the given style.
    public static func impact(_ style: HapticImpactStyle = .medium) {
        #if os(iOS)
        guard isHapticsAvailable else { return }
        UIImpactFeedbackGenerator(style: style.uiStyle).impactOccurred()
        #endif
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
        #if os(iOS)
        guard isHapticsAvailable else { return }
        UINotificationFeedbackGenerator().notificationOccurred(style.uiType)
        #endif
    }

    // MARK: - Selection

    /// Triggers a selection-changed haptic.
    public static func selection() {
        #if os(iOS)
        guard isHapticsAvailable else { return }
        UISelectionFeedbackGenerator().selectionChanged()
        #endif
    }

    // MARK: - Custom Intensity

    /// Triggers an impact haptic at a specific intensity.
    public static func custom(intensity: Double) {
        #if os(iOS)
        guard isHapticsAvailable else { return }
        let clamped = max(0.0, min(1.0, intensity))
        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: clamped)
        #endif
    }

    // MARK: - Sequence

    /// Plays a sequence of haptic events with a delay between each.
    public static func sequence(_ events: [HapticEvent], delay: TimeInterval = 0.1) {
        #if os(iOS)
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
        #endif
    }

    // MARK: - Private

    private static var isHapticsAvailable: Bool {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .phone ||
               UIDevice.current.userInterfaceIdiom == .pad
        #else
        return false
        #endif
    }
}

// MARK: - HapticEvent

/// A single haptic event used in a ``Haptic/sequence(_:delay:)``.
@MainActor
public enum HapticEvent: Sendable {
    case impact(HapticImpactStyle = .medium)
    case success
    case warning
    case error
    case selection
    case custom(intensity: Double)

    public func trigger() {
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
