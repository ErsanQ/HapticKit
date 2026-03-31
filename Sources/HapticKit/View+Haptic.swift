import SwiftUI

public extension View {
    /// Triggers haptic feedback when a specific value changes.
    ///
    /// - Parameters:
    ///   - style: The haptic style to play.
    ///   - value: The value to observe for changes.
    /// - Returns: A view that triggers haptics on value change.
    @MainActor
    func hapticFeedback<V: Equatable>(_ style: HapticStyle, trigger value: V) -> some View {
        self.onChange(of: value) { _ in
            Haptic.shared.play(style)
        }
    }
}
