//  swiftlint:disable:this file_name
//
//  Typealiases.swift
//  Survey
//
//  Created by Taher on 28/10/22.
//

import Foundation
import Combine

typealias Parameters = [String: AnyHashable]
typealias HTTPHeaders = [String: String]
typealias CancelBag = Set<AnyCancellable>
typealias Observable<T> = AnyPublisher<T, Error>
// R.swift
typealias ImageAssets = R.image
typealias ColorAssets = R.color
typealias FontAssets = R.font
typealias Localize = R.string.localizable
