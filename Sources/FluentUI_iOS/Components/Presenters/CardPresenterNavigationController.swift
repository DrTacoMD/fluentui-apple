//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI_common
import UIKit

class CardPresenterNavigationController: UINavigationController, CardPresentable {
    override func viewDidLoad() {
        super.viewDidLoad()
        FluentUIFramework.initializeUINavigationBarAppearance(navigationBar, navigationBarStyle: .dateTimePicker, fluentTheme: view.fluentTheme)
    }

    func idealSize() -> CGSize {
        guard let topVC = topViewController as? CardPresentable else {
            return .zero
        }

        var size = topVC.idealSize()
        size.height += navigationBar.frame.height
        return size
    }
}
