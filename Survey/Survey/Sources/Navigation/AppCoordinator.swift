//
//  AppCoordinator.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import FlowStacks
import SwiftUI

struct AppCoordinator: View {

    @ObservedObject var viewModel: AppCoordinatorViewModel

    var body: some View {
        NavigationView {
            Router($viewModel.routes) { screen, _ in
                switch screen {
                case .entry:
                    let viewModel = EntryViewModel(coordinator: viewModel)
                    EntryView(viewModel: viewModel)
                }
            }
        }
    }
}
