//
//  LoginRepositoryProtocol.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Combine

protocol LoginRepositoryProtocol: AnyObject {

    func getLoginToken(email: String, password: String) -> Observable<LoginTokenApi>
}
