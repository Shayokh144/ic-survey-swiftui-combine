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
    private let network = LoginNetworkAPI(decoder: JSONDecoder())

    init() {
        $didFinishSplashAnimation
            .filter { $0 }
            .sink { [weak self] _ in
                self?.goToNextView()
            }
            .store(in: &cancellables)
    }

    private func goToNextView() {
        let loginRepo = LoginRepository(network: network)
        let useCase = LoginUseCase(loginRepository: loginRepo)
        let viewModel = LoginViewModel(loginUseCase: useCase)
        viewType = .login(viewModel: viewModel)
        // TODO: add logic to check authentication and route accordingly
    }
}
