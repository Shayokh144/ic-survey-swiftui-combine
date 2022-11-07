//
//  LoginUseCaseProtocol.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Combine

protocol LoginUseCaseProtocol: AnyObject {

    func executeLogin(email: String, password: String) -> AnyPublisher<LoginTokenApi?, Error>
}
