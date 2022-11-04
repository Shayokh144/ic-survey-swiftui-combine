//
//  PasswordSecureTextField.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import SwiftUI

struct PasswordSecureTextField: View {

    @Binding var password: String
    @Binding var editingMode: Bool

    var body: some View {
        SecureField(String.empty, text: $password, onCommit: {
            self.editingMode = true
        })
        .placeholder(when: password.isEmpty) {
            Text(LocalizedTextAssets.localizable.password_placeholder())
                .foregroundColor(.gray)
        }
        .font(FontAssets.neuzeitSLTStdBook.font(size: 17.0))
        .accessibilityIdentifier("passwordSecureFieldId")
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
