//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI_shared
import UIKit
import SwiftUI

public extension FluentTheme {

    /// Returns the color value for the given token.
    ///
    /// - Parameter token: The `ColorsTokens` value to be retrieved.
    /// - Returns: A `UIColor` for the given token.
    @objc(colorForToken:)
    func color(_ token: ColorToken) -> UIColor {
        return UIColor(swiftUIColor(token))
    }

    /// Returns an array of colors for the given token.
    ///
    /// - Parameter token: The `GradientTokens` value to be retrieved.
    /// - Returns: An array of `UIColor` values for the given token.
    @objc(gradientColorsForToken:)
    func gradient(_ token: GradientToken) -> [UIColor] {
        let colors: [Color] = gradient(token)
        return colors.map { UIColor($0) }
    }
}
