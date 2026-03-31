import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

// MARK: - View+Haptic

public extension View {

    /// Triggers an impact haptic when `value` changes.
    @MainActor
    func hapticFeedback<T: Equatable>(
        _ event: HapticEvent,
        trigger value: T
    ) -> some View {
        self.onChange(of: value) { _, _ in
            #if canImport(UIKit)
            event.trigger()
            #endif
        }
    }

    /// Triggers a success haptic when `value` changes.
    @MainActor
    func hapticSuccess<T: Equatable>(trigger value: T) -> some View {
        hapticFeedback(.success, trigger: value)
    }

    /// Triggers an error haptic when `value` changes.
    @MainActor
    func hapticError<T: Equatable>(trigger value: T) -> some View {
        hapticFeedback(.error, trigger: value)
    }

    /// Triggers a selection haptic when `value` changes.
    @MainActor
    func hapticSelection<T: Equatable>(trigger value: T) -> some View {
        hapticFeedback(.selection, trigger: value)
    }
}
