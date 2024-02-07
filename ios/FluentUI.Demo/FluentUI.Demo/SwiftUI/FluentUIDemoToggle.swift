//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI
import SwiftUI
#if SWIFT_MODULE
import FluentUI_Core_iOS
#endif

struct FluentUIDemoToggle: View {
    var titleKey: LocalizedStringKey
    var isOn: Binding<Bool>
    @Environment(\.fluentTheme) public var fluentTheme: FluentTheme

    var body: some View {
        Toggle(titleKey, isOn: isOn)
            .tint(Color(fluentTheme.color(.brandForeground1)))
    }
}
