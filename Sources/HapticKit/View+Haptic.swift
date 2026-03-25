#if canImport(UIKit)
import SwiftUI

// MARK: - View+Haptic

public extension View {

    /// Triggers an impact haptic when `value` changes.
    ///
    /// ```swift
    /// Toggle("Dark Mode", isOn: $isDarkMode)
    ///     .hapticFeedback(.impact(.medium), trigger: isDarkMode)
    /// ```
    @MainActor
    func hapticFeedback<T: Equatable>(
        _ event: HapticEvent,
        trigger value: T
    ) -> some View {
        self.onChange(of: value) { _, _ in
            event.trigger()
        }
    }

    /// Triggers a success haptic when `value` changes.
    ///
    /// ```swift
    /// Button("Save") { save() }
    ///     .hapticSuccess(trigger: isSaved)
    /// ```
    @MainActor
    func hapticSuccess<T: Equatable>(trigger value: T) -> some View {
        hapticFeedback(.success, trigger: value)
    }

    /// Triggers an error haptic when `value` changes.
    ///
    /// ```swift
    /// TextField("Email", text: $email)
    ///     .hapticError(trigger: hasError)
    /// ```
    @MainActor
    func hapticError<T: Equatable>(trigger value: T) -> some View {
        hapticFeedback(.error, trigger: value)
    }

    /// Triggers a selection haptic when `value` changes.
    ///
    /// ```swift
    /// Picker("Theme", selection: $theme) { ... }
    ///     .hapticSelection(trigger: theme)
    /// ```
    @MainActor
    func hapticSelection<T: Equatable>(trigger value: T) -> some View {
        hapticFeedback(.selection, trigger: value)
    }
}
#endif
