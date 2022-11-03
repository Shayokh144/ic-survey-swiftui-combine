//
//  LoginButton.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import SwiftUI

struct LoginButton: View {
    var body: some View {
        Text(LocalizedTextAssets.localizable.login_button())
            .font(FontAssets.neuzeitSLTStdBookHeavy.font(size: 17.0))
            .foregroundColor(.black)
            .frame(width: 327.0, height: 56.0)
            .background(Color.white)
            .cornerRadius(10.0)
    }
}
