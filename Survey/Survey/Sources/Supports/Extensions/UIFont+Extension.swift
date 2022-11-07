//
//  Extension+UIFont.swift
//  Survey
//
//  Created by Taher on 7/11/22.
//

import Foundation
import SwiftUI

extension UIFont {

    static func regular(ofSize size: FontSize) -> UIFont {
        FontFamily.neuzeitSLTStdBook.regular(ofSize: size)
    }

    static func semiBold(ofSize size: FontSize) -> UIFont {
        FontFamily.neuzeitSLTStdBook.semiBold(ofSize: size)
    }
}

extension UIFont {

    enum FontSize: CGFloat {

        /// 11px
        case xxxSmall = 11.0

        /// 12px
        case xxSmall = 12.0

        /// 13px
        case xSmall = 13.0

        /// 14px
        case small = 14.0

        /// 16px
        case regular = 17.0

        /// 18px
        case medium = 18.0

        /// 20px
        case large = 20.0

        /// 24px
        case headingLarge = 24.0

        /// 30px
        case xLarge = 30.0

        /// 32px
        case xxLarge = 32.0
    }

    enum FontFamily {

        case neuzeitSLTStdBook

        func regular(ofSize size: FontSize) -> UIFont {
            FontAssets.neuzeitSLTStdBook(size: size.rawValue) ?? .systemFont(ofSize: size.rawValue)
        }

        func semiBold(ofSize size: FontSize) -> UIFont {
            FontAssets
                .neuzeitSLTStdBookHeavy(size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .semibold)
        }
    }
}
