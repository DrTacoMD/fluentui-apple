//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

extension Color {
    /// Creates a `Color` instance with the specified three-channel, 8-bit-per-channel color value, usually in hex.
    ///
    /// For example: `0xFF0000` represents red, `0x00FF00` green, and `0x0000FF` blue. There is no way to specify an
    /// alpha channel via this initializer. For that, use the `.opacity(:)` modifier on the resulting `Color` instance.
    ///
    /// - Parameter hexValue: The color value to store, in 24-bit (three-channel, 8-bit) RGB.
    ///
    /// - Returns: A color object that stores the provided color information.
    init(hexValue: UInt32) {
        let red: CGFloat = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
        let green: CGFloat = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
        let blue: CGFloat = CGFloat(hexValue & 0x000000FF) / 255.0
        self.init(red: red,
                  green: green,
                  blue: blue)
    }

    /// Creates a custom `Color` that stores a dynamic set of `Color` values.
    ///
    /// - Parameter light: The default `Color` for a light context. Required.
    /// - Parameter dark: The override `Color` for a dark context. Optional.
    /// - Parameter darkElevated: The override `Color` for a dark elevated context. Optional.
    init(light: Color,
         dark: Color? = nil,
         darkElevated: Color? = nil) {

        let dynamicColor = DynamicColor(light: light, dark: dark, darkElevated: darkElevated)
        if #available(iOS 17, macOS 14, *) {
            self.init(dynamicColor)
        } else {
#if os(iOS) || os(visionOS)
            // TODO: ???
            //self.init(uiColor: UIColor(dynamicColor: dynamicColor))
            self.init(cgColor: GlobalTokens.sharedSwiftUIColor(.hotPink, .primary).cgColor!)
#elseif os(macOS)
            self.init(cgColor: GlobalTokens.sharedSwiftUIColor(.hotPink, .primary).cgColor!)
#endif // os(iOS) || os(visionOS)
        }
    }

    public init(dynamicColor: DynamicColor) {
        if #available(iOS 17, macOS 14, *) {
            self.init(dynamicColor)
        } else {
            // TODO: ???
#if os(iOS) || os(visionOS)
//            self.init(uiColor: UIColor(dynamicColor: dynamicColor))
            self.init(cgColor: GlobalTokens.sharedSwiftUIColor(.hotPink, .primary).cgColor!)
#elseif os(macOS)
            self.init(cgColor: GlobalTokens.sharedSwiftUIColor(.hotPink, .primary).cgColor!)
#endif // os(iOS) || os(visionOS)
        }
    }
}
