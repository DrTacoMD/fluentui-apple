//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
#if SWIFT_MODULE
import FluentUI_Core_iOS
#endif

@objc public extension UIViewController {
    var msfNavigationController: NavigationController? {
        return navigationController as? NavigationController
    }
}
