//
//  AppCoordinatorViewModel.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import FlowStacks
import SwiftUI

class AppViewModel: ObservableObject {

    @Published var routes: Routes<AppScreenType>

    init() {
        routes = [.root(.entry)]
    }

    func goBack() {
        routes.goBack()
    }

    func goBackToRoot() {
        routes.goBackToRoot()
    }
}
