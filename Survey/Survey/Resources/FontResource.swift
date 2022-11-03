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
}
