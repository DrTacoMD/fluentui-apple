//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
#if SWIFT_MODULE
import FluentUI_Core_iOS
#endif

/// Design token set for the `PeoplePicker` control.
public class PeoplePickerTokenSet: BadgeFieldTokenSet {}

// MARK: Constants
extension PeoplePickerTokenSet {
    static let personaSuggestionsVerticalMargin: CGFloat = GlobalTokens.spacing(.size80)
}
