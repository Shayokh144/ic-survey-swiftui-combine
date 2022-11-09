//
//  FontResource.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import Rswift
import SwiftUI

extension FontResource {

    func font(size: CGFloat) -> Font {
        Font.custom(fontName, size: size)
    }

    func regular() -> Font {
        Font(UIFont.regular(ofSize: UIFont.FontSize.regular))
    }

    func semiBold() -> Font {
        Font(UIFont.semiBold(ofSize: UIFont.FontSize.regular))
    }
}
