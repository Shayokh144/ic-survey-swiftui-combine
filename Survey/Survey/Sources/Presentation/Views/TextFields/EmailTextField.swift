//
//  EmailTextField.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import SwiftUI

struct EmailTextField: View {

    @Binding var email: String
    @Binding var editingMode: Bool

    var body: some View {
        TextField(String.empty, text: $email).placeholder(when: email.isEmpty) {
            Text(LocalizedTextAssets.localizable.email_placeholder())
                .foregroundColor(.gray)
        }
        .font(FontAssets.neuzeitSLTStdBook.font(size: 17.0))
        .accessibilityIdentifier("emailTextFieldId")
        .padding()
        .foregroundColor(.white)
        .background(ColorAssets.textFieldBackground.color)
        .cornerRadius(12.0)
        .frame(width: 327.0, height: 56.0, alignment: .center)
        .onTapGesture {
            if self.editingMode == false {
                withAnimation(.linear(duration: 0.2)) {
                    self.editingMode = true
                }
            }
        }
    }
}
