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

    private var cancellables = CancelBag()
    private let coordinator: AppViewModel
    private let network: LoginNetworkAPI
    private let loginRepo: LoginRepository
    private let loginUseCase: LoginUseCase

    init(
        coordinator: AppViewModel,
        network: LoginNetworkAPI,
        loginRepo: LoginRepository,
        loginUseCase: LoginUseCase
    ) {
        self.coordinator = coordinator
        self.network = network
        self.loginRepo = loginRepo
        self.loginUseCase = loginUseCase

        $didFinishSplashAnimation
            .filter { $0 }
            .sink { [weak self] _ in
                self?.goToNextView()
            }
            .store(in: &cancellables)
    }

    private func goToNextView() {
        let viewModel = LoginViewModel(loginUseCase: loginUseCase, coordinator: coordinator)
        viewType = .login(viewModel: viewModel)
        // TODO: add logic to check authentication and route accordingly
    }
}
