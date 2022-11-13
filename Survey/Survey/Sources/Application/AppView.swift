//
//  AppVIew.swift
//  Survey
//
//  Created by Taher on 8/11/22.
//

import FlowStacks
import SwiftUI

struct AppView: View {

    @ObservedObject private var viewModel: AppViewModel

    var body: some View {

        NavigationView {
            Router($viewModel.routes) { screen, _ in
                switch screen {
                case let .entry(network, repo, useCase):
                    let entryViewModel = EntryViewModel(
                        coordinator: viewModel,
                        network: network,
                        loginRepo: repo,
                        loginUseCase: useCase
                    )
                    EntryView(viewModel: entryViewModel)
                case .surveyList:
                    SurveyListView()
                }
            }
        }
    }

    init(viewModel: AppViewModel) {
        self.viewModel = viewModel
    }
}
