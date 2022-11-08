//
//  EntryViewModel.swift
//  Survey
//
//  Created by Taher on 2/11/22.
//

import Combine
import SwiftUI

class EntryViewModel: ObservableObject {

    @Published private(set) var viewType: EntryViewType = .splash
    @Published var didFinishSplashAnimation = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        $didFinishSplashAnimation
            .filter { $0 }
            .sink { [weak self] _ in
                self?.goToNextView()
            }
            .store(in: &cancellables)
    }

    private func goToNextView() {
        viewType = .login
        // TODO: add logic to check authentication and route accordingly
    }
}
