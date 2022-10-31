//
//  OverlayView.swift
//  Survey
//
//  Created by Taher on 28/10/22.
//

import SwiftUI

enum OverlayView {

    case splashScreen

    var colors: [Color] {
        switch self {
        case .splashScreen:
            return [
                Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.01),
                Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.0)
            ]
        }
    }

    var linearGradient: some View {
        switch self {
        case .splashScreen:
            return Rectangle()
                .fill(
                    LinearGradient(
                        colors: colors,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .ignoresSafeArea()
        }
    }
}
