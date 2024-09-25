//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI_common
import UIKit

public extension ShadowInfo {
    /// Applies a key and an ambient shadow on a `UIView`.
    /// - Parameters:
    ///   - view: The view on which the shadows will be applied.
    ///   - parentController: The view controller responsible for the view on which the shadows will be applied.
    func applyShadow(to view: UIView, parentController: UIViewController? = nil) {
        guard var shadowable = (view as? Shadowable) ?? (view.superview as? Shadowable) ?? (parentController as? Shadowable) else {
            assertionFailure("Cannot apply Fluent shadows to a non-Shadowable view")
            return
        }

        shadowable.ambientShadow?.removeFromSuperlayer()
        shadowable.keyShadow?.removeFromSuperlayer()

        let ambientShadow = initializeShadowLayer(view: view, isAmbientShadow: true)
        let keyShadow = initializeShadowLayer(view: view)

        shadowable.ambientShadow = ambientShadow
        shadowable.keyShadow = keyShadow

        view.layer.insertSublayer(ambientShadow, at: 0)
        view.layer.insertSublayer(keyShadow, below: ambientShadow)
    }

    /// Initializes a `CALayer` with the relevant `ShadowInfo` values.
    /// - Parameters:
    ///   - view: The view on which the shadow layer will be applied.
    ///   - isAmbientShadow: Determines whether to apply ambient or key shadow values on the layer.
    /// - Returns: The modified `CALayer`.
    func initializeShadowLayer(view: UIView, isAmbientShadow: Bool = false) -> CALayer {
        let layer = CALayer()

        layer.frame = view.bounds
        layer.shadowColor = (isAmbientShadow ? ambientColor : keyColor).cgColor
        layer.shadowRadius = isAmbientShadow ? ambientBlur : keyBlur

        // The shadowOpacity needs to be set to 1 since the alpha is already set through shadowColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: isAmbientShadow ? xAmbient : xKey,
                                    height: isAmbientShadow ? yAmbient : yKey)
        layer.needsDisplayOnBoundsChange = true
        layer.cornerRadius = view.layer.cornerRadius
        layer.backgroundColor = view.backgroundColor?.cgColor

        return layer
    }
}
