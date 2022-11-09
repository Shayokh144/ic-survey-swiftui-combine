//
//  LoginViewModel.swift
//  Survey
//
//  Created by Taher on 7/11/22.
//

import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {

    // MARK: Input

    @Published var email: String = .empty
    @Published var password: String = .empty

    // MARK: Output

    @Published var isLoginFailed: Bool = false
    @Published private(set) var errorMessage: String = .empty
    @Published private(set) var isLoading: Bool = false

    private let loginUseCase: LoginUseCaseProtocol
    private var cancellables = CancelBag()
    private let coordinator: AppViewModel
    private let keyChain: KeychainHelper

    init(
        loginUseCase: LoginUseCase,
         coordinator: AppViewModel,
        keyChain: KeychainHelper = .shared
    ) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator
        self.keyChain = keyChain
    }

    private func showErrorMessage(message: String) {
        isLoading = false
        errorMessage = message
        isLoginFailed = true
    }

    func login() {
        isLoading = true
        guard ValidityChecker.isValidEmail(address: email) else {
            showErrorMessage(message: Localize.invalid_email_description())
            return
        }
        guard ValidityChecker.isValidPasswordFormat(password: password) else {
            showErrorMessage(message: Localize.invalid_password_format())
            return
        }
        loginUseCase
            .executeLogin(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let owner = self else {
                        return
                    }
                    switch completion {
                    case let .failure(error):
                        NSLog("ERROR: \(error.localizedDescription)")
                        owner.showErrorMessage(message: Localize.login_failed_description())
                    case .finished:
                        NSLog("Login token response finished")
                    }
                },
                receiveValue: { [weak self] data in
                    guard let owner = self else {
                        return
                    }
                    owner.saveLoginToken(data: data)
                    owner.goToSurveyListView()
                }
            )
            .store(in: &cancellables)
    }

    private func saveLoginToken(data: LoginTokenApi) {
        keyChain.save(item: data)
    }

    private func goToSurveyListView() {
        coordinator.loadSurveyListView()
    }
}
