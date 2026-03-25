# HapticKit

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9-orange?logo=swift" alt="Swift 5.9"/>
  <img src="https://img.shields.io/badge/iOS-16%2B-blue?logo=apple" alt="iOS 16+"/>
  <img src="https://img.shields.io/badge/SPM-compatible-green" alt="SPM compatible"/>
  <img src="https://img.shields.io/badge/license-MIT-lightgrey" alt="MIT License"/>
</p>

<p align="center">
  Haptic feedback in one line. No generators. No setup. No noise.
</p>

---

> **[GIF placeholder]**

---

## The Problem

```swift
// 😭 Native API — 4 lines for a single tap
let generator = UIImpactFeedbackGenerator(style: .medium)
generator.prepare()
generator.impactOccurred()
```

## The Solution

```swift
// 😍 HapticKit — 1 line
Haptic.impact()
```

---

## Features

- ✅ `Haptic.impact()` — light, medium, heavy, rigid, soft
- ✅ `Haptic.success()` / `.warning()` / `.error()`
- ✅ `Haptic.selection()` — for pickers and toggles
- ✅ `Haptic.custom(intensity: 0.75)` — precise control
- ✅ `Haptic.sequence([...], delay:)` — chain multiple haptics
- ✅ SwiftUI modifiers — `.hapticFeedback()`, `.hapticSuccess()`, `.hapticError()`
- ✅ Automatically disabled on iPad and non-haptic devices
- ✅ Zero dependencies — wraps native `UIFeedbackGenerator`
- ✅ iOS 16+, watchOS 9+, visionOS 1+

---

## Installation

```
https://github.com/ErsanQ/HapticKit
```

Or in `Package.swift`:

```swift
.package(url: "https://github.com/ErsanQ/HapticKit", from: "1.0.0")
```

---

## Usage

### Impact

```swift
Haptic.impact()           // medium (default)
Haptic.impact(.light)
Haptic.impact(.heavy)
Haptic.impact(.rigid)
Haptic.impact(.soft)
```

### Notification

```swift
Haptic.success()   // task completed ✅
Haptic.warning()   // caution ⚠️
Haptic.error()     // something went wrong ❌
```

### Selection

```swift
Haptic.selection() // great for pickers, sliders, tab bars
```

### Custom Intensity

```swift
Haptic.custom(intensity: 0.3)  // subtle
Haptic.custom(intensity: 1.0)  // maximum
```

### Sequences

```swift
// Double tap
Haptic.sequence([.impact(.light), .impact(.heavy)], delay: 0.1)

// Success celebration
Haptic.sequence([
    .impact(.light),
    .impact(.medium),
    .impact(.heavy),
    .success
], delay: 0.08)
```

### SwiftUI Modifiers

```swift
// Trigger on value change
Toggle("Notifications", isOn: $isOn)
    .hapticFeedback(.impact(.medium), trigger: isOn)

// On success
Button("Save") { save() }
    .hapticSuccess(trigger: isSaved)

// On error
TextField("Email", text: $email)
    .hapticError(trigger: hasError)

// On selection
Picker("Theme", selection: $theme) { ... }
    .hapticSelection(trigger: theme)
```

---

## API Reference

### `Haptic`

| Method | Description |
|--------|-------------|
| `impact(_ style:)` | Impact feedback (default: `.medium`) |
| `success()` | Success notification |
| `warning()` | Warning notification |
| `error()` | Error notification |
| `notify(_ style:)` | Notification with explicit style |
| `selection()` | Selection changed |
| `custom(intensity:)` | Impact at custom intensity (0.0–1.0) |
| `sequence(_ events:delay:)` | Chain multiple haptics |

### `HapticEvent` (for sequences)

`.impact(.light/medium/heavy/rigid/soft)` · `.success` · `.warning` · `.error` · `.selection` · `.custom(intensity:)`

---

## Requirements

- iOS 16.0+ / watchOS 9.0+ / visionOS 1.0+
- Swift 5.9+
- Xcode 15.0+

---

## License

HapticKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

---

## Author

Built by **Ersan Q Abo Esha** — [@ErsanQ](https://github.com/ErsanQ)

If HapticKit saved you time, consider giving it a ⭐️ on [GitHub](https://github.com/ErsanQ/HapticKit).
