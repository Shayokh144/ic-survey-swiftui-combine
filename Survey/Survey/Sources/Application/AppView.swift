//
//  AppVIew.swift
//  Survey
//
//  Created by Taher on 8/11/22.
//

import FlowStacks
import SwiftUI

struct AppView: View {

    @ObservedObject var viewModel: AppViewModel

    var body: some View {

        NavigationView {
            Router($viewModel.routes) { screen, _ in
                switch screen {
                case .entry:
                    let viewModel = EntryViewModel(coordinator: viewModel)
                    EntryView(viewModel: viewModel)
                case .surveyList:
                    SurveyListView()
                }
            }
        }
    }
}
