//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
#if SWIFT_MODULE
import FluentUI_Core_iOS
#endif

/// An error object with a localized description used by the `FluentTextField`.
@objc(MSFTextInputError)
open class FluentTextInputError: NSObject {
    @objc public init(localizedDescription: String) {
        self.localizedDescription = localizedDescription
        super.init()
    }

    @objc public let localizedDescription: String
}
