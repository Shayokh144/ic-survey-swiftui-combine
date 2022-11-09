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

    init(loginUseCase: LoginUseCase, coordinator: AppViewModel) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator

        /*didTapLoginButton.sink { [weak self] _ in
            guard let owner = self else {
                return
            }
            owner.isLoading = true
            guard ValidityChecker.isValidEmail(address: owner.email) else {
                owner.showErrorMessage(message: Localize.invalid_email_description())
                return
            }
            guard ValidityChecker.isValidPasswordFormat(password: owner.password) else {
                owner.showErrorMessage(message: Localize.invalid_password_format())
                return
            }
            owner.login()
        }
        .store(in: &disposables)*/
    }

    private func showErrorMessage(message: String) {
        isLoading = false
        errorMessage = message
        isLoginFailed = true
    }

    func login() {
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
                    guard let tokenData = data else {
                        NSLog("ERROR: No login token data found for given credentials")
                        owner.showErrorMessage(message: Localize.login_failed_description())
                        return
                    }
                    owner.saveLoginToken(data: tokenData)
                    owner.goToSurveyListView()
                }
            )
            .store(in: &cancellables)
    }

    private func saveLoginToken(data: LoginTokenApi) {
        KeychainHelper.shared.save(item: data)
    }

    private func goToSurveyListView() {
        coordinator.loadSurveyListView()
    }
}
