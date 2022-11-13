//
//  BlurView.swift
//  Survey
//
//  Created by Taher on 13/11/22.
//

import SwiftUI

struct BlurView: View {

    @State var opacity = 0.4

    var body: some View {
        Color(.black)
            .ignoresSafeArea()
            .opacity(opacity)
    }
}
