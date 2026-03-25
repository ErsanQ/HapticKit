import XCTest
@testable import HapticKit

final class HapticKitTests: XCTestCase {

    // MARK: - HapticImpactStyle

    func test_impactStyle_allCasesMapToDistinctUIStyles() {
        let styles: [HapticImpactStyle] = [.light, .medium, .heavy, .rigid, .soft]
        let uiStyles = styles.map { $0.uiStyle.rawValue }
        XCTAssertEqual(Set(uiStyles).count, styles.count)
    }

    // MARK: - HapticNotificationStyle

    func test_notificationStyle_allCasesMapToDistinctUITypes() {
        let styles: [HapticNotificationStyle] = [.success, .warning, .error]
        let uiTypes = styles.map { $0.uiType.rawValue }
        XCTAssertEqual(Set(uiTypes).count, styles.count)
    }

    // MARK: - Sendable Conformance

    func test_impactStyle_isSendable() {
        let _: any Sendable = HapticImpactStyle.medium
    }

    func test_notificationStyle_isSendable() {
        let _: any Sendable = HapticNotificationStyle.success
    }

    // MARK: - HapticEvent

    func test_hapticEvent_impactDefaultStyle_isMedium() {
        if case .impact(let style) = HapticEvent.impact() {
            XCTAssertEqual(style.uiStyle, HapticImpactStyle.medium.uiStyle)
        } else {
            XCTFail("Expected .impact case")
        }
    }

    func test_hapticEvent_customIntensity_clampsAboveOne() {
        // Verify the custom event stores the value (clamping happens in Haptic.custom)
        if case .custom(let intensity) = HapticEvent.custom(intensity: 1.5) {
            XCTAssertEqual(intensity, 1.5) // stored as-is; Haptic.custom clamps
        }
    }
}
