//
//  AppViewModel.swift
//  Survey
//
//  Created by Taher on 8/11/22.
//

import FlowStacks
import SwiftUI

class AppViewModel: ObservableObject, AppCoordinatorProtocol {

    @Published var routes: Routes<AppScreenType>

    init() {
        let network = LoginNetworkAPI(decoder: JSONDecoder())
        let loginRepo = LoginRepository(network: network)
        let useCase = LoginUseCase(loginRepository: loginRepo)
        routes = [.root(.entry(network, loginRepo, useCase))]
    }

    func goBack() {
        routes.goBack()
    }

    func goBackToRoot() {
        routes.goBackToRoot()
    }

    func loadSurveyListAsRootView() {
        routes = [.root(.surveyList)]
    }
}
