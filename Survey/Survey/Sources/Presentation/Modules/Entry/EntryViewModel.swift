//
//  EntryViewModel.swift
//  Survey
//
//  Created by Taher on 2/11/22.
//

import Combine
import SwiftUI

class EntryViewModel: ObservableObject {

    @Published var viewType: EntryViewType = .splash
    var didFinishSplashAnimation = PassthroughSubject<Void, Never>()
    let coordinator: AppCoordinatorViewModel
    private var disposables = Set<AnyCancellable>()

    init(coordinator: AppCoordinatorViewModel) {
        self.coordinator = coordinator

        didFinishSplashAnimation.sink { [weak self] _ in
            self?.goToNextView()
        }
        .store(in: &disposables)
    }

    private func goToNextView() {
        viewType = .login
        // To-Do: add logic to check authentication and route accordingly
    }
}
