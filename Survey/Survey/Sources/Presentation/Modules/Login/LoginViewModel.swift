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
    var didTapLoginButton = PassthroughSubject<Void, Never>()

    // MARK: Output

    @Published var errorMessage: String = .empty

    private let loginUseCase: LoginUseCaseProtocol
    private var disposables = CancelBag()

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase

        didTapLoginButton.sink { [weak self] _ in
            // TODO: check email pattern validity in integration task
            self?.login()
        }
        .store(in: &disposables)
    }

    private func login() {
        loginUseCase
            .executeLogin(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        NSLog("ERROR: \(error.localizedDescription)")
                    // TODO: show error message in integration task
                    case .finished:
                        NSLog("Login token response finished")
                    }
                }, receiveValue: { data in
                    guard let tokenData = data else {
                        NSLog("ERROR: No login token data found")
                        // TODO: show error message in integration task
                        return
                    }
                    print(tokenData) // TODO: will remove in integration task
                    // TODO: save data in keychain in integration task
                    // TODO: move to next view in integration task
                }
            )
            .store(in: &disposables)
    }
}
