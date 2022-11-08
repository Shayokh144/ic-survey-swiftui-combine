//
//  LoginButton.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import SwiftUI

struct LoginButton: View {
    
    var body: some View {

        Text(Localize.login_button())
            .font(FontAssets.neuzeitSLTStdBook.semiBold())
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 56.0, alignment: .center)
            .background(Color.white)
            .cornerRadius(12.0)
            .padding(.horizontal, 24)
    }
}
