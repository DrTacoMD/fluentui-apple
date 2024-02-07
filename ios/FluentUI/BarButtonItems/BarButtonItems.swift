//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
#if SWIFT_MODULE
import FluentUI_Core_iOS
#endif

public final class BarButtonItems: NSObject {
    /// When adding this barButtonItem to the view, tint it with appropriate app color UIColor(light: Colors.primary(for: window), dark: Colors.textDominant)
    @objc static func confirm(target: Any?, action: Selector?) -> UIBarButtonItem {
        let image = FluentUIFramework.staticImageNamed("checkmark-24x24")
        let landscapeImage = FluentUIFramework.staticImageNamed("checkmark-thin-20x20")

        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImage, style: .plain, target: target, action: action)
        button.accessibilityLabel = FluentUIFramework.localized("Accessibility.Done.Label")
        return button
    }

    private override init() {
        super.init()
    }
}
