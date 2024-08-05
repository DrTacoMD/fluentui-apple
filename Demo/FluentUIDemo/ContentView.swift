//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI
import FluentUI

/// Definition of a DemoController
struct DemoDescriptor: Identifiable, Hashable {
    let title: String
    let id = UUID()
}

let demos: [DemoDescriptor] = [
    DemoDescriptor(title: "Avatar"),
    DemoDescriptor(title: "Button")
]

struct ContentView: View {
#if os(macOS)
    // Until we have a SwiftUI button on macOS, this will have to do.
    private struct ButtonRepresentable: NSViewRepresentable {
        func makeNSView(context: Context) -> some NSView {
            return FluentUI.Button(title: "Hello, world!",
                                   image: .init(systemSymbolName: "globe", accessibilityDescription: nil))
        }

        func updateNSView(_ nsView: NSViewType, context: Context) {
        }
    }
#endif

    @State private var currentDemo: DemoDescriptor?
    @State var date = Date()

    var body: some View {
        NavigationSplitView {
            List(demos, selection: $currentDemo) { demo in
                NavigationLink(demo.title, value: demo)
            }
        } detail: {
            if let title = currentDemo?.title {
                DetailView(value: title)
            } else {
                Text("Choose a link")
                    .font(Font(FluentTheme.shared.typography(.largeTitle)))
            }
        }
    }

    struct DetailView: View {
        var value: String

        var body: some View {
            if value == "Button" {
                buttonDemo
            } else {
                avatarDemo
            }
        }

        @ViewBuilder
        var avatarDemo: some View {
            Avatar(style: .outlinedPrimary, size: .size72)
        }

        @ViewBuilder
        var buttonDemo: some View {
            VStack {
    #if os(macOS)
                ButtonRepresentable()
                    .fixedSize()
    #else
                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                        Text("Hello, world!")
                    }
                })
                .buttonStyle(FluentButtonStyle(style: .accent))
                .controlSize(.extraLarge)
    #endif
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
