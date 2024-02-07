//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

extension View {
    /// Applies modifiers defined in a closure if a condition is met.
    /// - Parameters:
    ///   - condition: Condition that need to be met so that the closure is applied to the View.
    ///   - modifications: Closure that outlines the modifiers that will be applied to the View should the condition evaluate to true.
    /// - Returns: The resulting View either with the modifications applied (if condition is true) or in its original state (if condition is false).
    @ViewBuilder
    public func modifyIf<Content: View>(_ condition: Bool,
                                 _ modifications: (Self) -> Content) -> some View {
        if condition {
            modifications(self)
        } else {
            self
        }
    }

    /// Enables iPad Pointer interaction for the view if available.
    /// - Parameter isEnabled: Whether the pointer interaction should be enabled.
    /// - Returns: The modified view.
    public func pointerInteraction(_ isEnabled: Bool) -> AnyView {
        if isEnabled {
            return AnyView(self.hoverEffect())
        }

        return AnyView(self)
    }

    /// Adds a large content viewer for the view. If the text and image are both nil,
    /// the default large content viewer will be used.
    /// - Parameters:
    ///  - text: Optional String to display in the large content viewer.
    ///  - image: Optional UIImage to display in the large content viewer.
    /// - Returns: The modified view.
    public func showsLargeContentViewer(text: String? = nil, image: UIImage? = nil) -> some View {
        modifier(LargeContentViewerModifier(text: text, image: image))
    }

    /// Applies multiple shadows on a View
    /// - Parameters:
    ///  - shadowInfo: The values of the two shadows to be applied
    /// - Returns: The modified view.
    public func applyShadow(shadowInfo: ShadowInfo) -> some View {
        modifier(ShadowModifier(shadowInfo: shadowInfo))
    }

    /// Abstracts away differences in pre-iOS 17 `onChange(of:perform:)` versus post-iOS 17 `onChange(of:_:)`.
    ///
    /// This function will be removed once FluentUI moves to iOS 17 as a minimum target.
    /// - Parameters:
    ///   - value: The value to check against when determining whether to run the closure.
    ///   - action: A closure to run when the value changes.
    /// - Returns: A view that fires an action when the specified value changes.
    public func fluent_onChange_iOS17<V>(of value: V, _ action: @escaping (V) -> Void) -> some View where V: Equatable {
        if #available(iOS 17, *) {
            return self.onChange(of: value) { _, newValue in
                return action(newValue)
            }
        } else {
            return self.onChange(of: value, perform: action)
        }
    }
}

/// ViewModifier for showing the large content viewer with optional text and optional image.
/// If both the text and image are nil, the default large content viewer will be used.
struct LargeContentViewerModifier: ViewModifier {
    init(text: String?, image: UIImage?) {
        self.text = text
        self.image = image
    }

    func body(content: Content) -> some View {
        if text != nil || image != nil {
            content.accessibilityShowsLargeContentViewer({
                if let image = image {
                    Image(uiImage: image)
                }
                if let text = text {
                    Text(text)
                }
            })
        } else {
            content.accessibilityShowsLargeContentViewer()
        }
    }

    private var text: String?
    private var image: UIImage?
}

/// ViewModifier that applies both shadows from a ShadowInfo
struct ShadowModifier: ViewModifier {
    var shadowInfo: ShadowInfo

    init(shadowInfo: ShadowInfo) {
        self.shadowInfo = shadowInfo
    }

    func body(content: Content) -> some View {
        content
            .shadow(color: Color(shadowInfo.ambientColor),
                    radius: shadowInfo.ambientBlur,
                    x: shadowInfo.xAmbient,
                    y: shadowInfo.yAmbient)
            .shadow(color: Color(shadowInfo.keyColor),
                    radius: shadowInfo.keyBlur,
                    x: shadowInfo.xKey,
                    y: shadowInfo.yKey)
    }
}
