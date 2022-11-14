//
//  MockAppCoordinator.swift
//  Survey
//
//  Created by Taher on 14/11/22.
//

import Foundation

final class MockAppCoordinator: AppCoordinatorProtocol {

    var isSurveyViewLoaded = false

    func loadSurveyListAsRootView() {
        isSurveyViewLoaded = true
    }

    func goBack() {}

    func goBackToRoot() {}
}
