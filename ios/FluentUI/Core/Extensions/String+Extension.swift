//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

public struct FluentStringHelpers {
    public static func trimmed(_ string: String) -> String {
        var whitespace = CharacterSet(charactersIn: "\u{200B}") // Zero-width space
        whitespace.formUnion(CharacterSet.whitespacesAndNewlines)
        return string.trimmingCharacters(in: whitespace)
    }

    public static func preferredSize(_ string: String, for font: UIFont, width: CGFloat = .greatestFiniteMagnitude, numberOfLines: Int = 0) -> CGSize {
        let lineHeightWithLeading = ceil(font.lineHeight + max(0, font.leading))
        if numberOfLines == 1 {
            return CGSize(
                width: ceil(min(string.size(withAttributes: [.font: font]).width, width)),
                height: lineHeightWithLeading
            )
        }
        let maxHeight = numberOfLines > 1 ? lineHeightWithLeading * CGFloat(numberOfLines) : .greatestFiniteMagnitude
        let rect = string.boundingRect(
            with: CGSize(width: width, height: maxHeight),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return CGSize(
            width: ceil(rect.width),
            height: ceil(rect.height)
        )
    }
}
