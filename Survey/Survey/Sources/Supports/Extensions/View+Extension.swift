//
//  View.swift
//  Survey
//
//  Created by Taher on 2/11/22.
//

import SwiftUI

extension View {

    func onAnimationCompleted<Value: VectorArithmetic>(
        for value: Value,
        completion: @escaping () -> Void
    ) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }

    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
                .opacity(shouldShow ? 0.3 : 0.0)
                .font(FontAssets.neuzeitSLTStdBook.font(size: 17.0))
            self
        }
    }
}
