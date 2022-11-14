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

    @Published private(set) var isLoginAttemptFailed: Bool = false
    @Published private(set) var errorMessage: String = .empty
    @Published private(set) var isLoading: Bool = false

    private let loginUseCase: LoginUseCaseProtocol
    private var cancellables = CancelBag()
    private let coordinator: AppCoordinatorProtocol
    private let keyChain: KeychainHelper
    private let validityChecker: ValidityChecker

    init(
        loginUseCase: LoginUseCaseProtocol,
        coordinator: AppCoordinatorProtocol,
        keyChain: KeychainHelper = .shared,
        validityChecker: ValidityChecker = ValidityChecker()
    ) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator
        self.keyChain = keyChain
        self.validityChecker = validityChecker
    }

    private func showErrorMessage(message: String) {
        isLoading = false
        errorMessage = message
        isLoginAttemptFailed = true
    }

    func didDismissLoginFailedAlert() {
        isLoginAttemptFailed = false
    }

    func login() {
        isLoading = true
        guard validityChecker.isValidEmail(address: email) else {
            showErrorMessage(message: Localize.invalid_email_description())
            return
        }
        guard validityChecker.isValidPasswordFormat(password: password) else {
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
        do {
            try keyChain.saveString(key: KeyChainConstants.accessTokenKey, value: data.accessToken)
            try keyChain.saveString(key: KeyChainConstants.refreshTokenKey, value: data.refreshToken)
        } catch let error as KeyChainError {
            print(error.errorDescription)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func goToSurveyListView() {
        coordinator.loadSurveyListAsRootView()
    }
}
