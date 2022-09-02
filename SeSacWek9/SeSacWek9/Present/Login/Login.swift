//
//  File.swift
//  SeSacWek9
//
//  Created by useok on 2022/09/01.
//

import Foundation

class LoginViewModel {
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var name: Observable<String> = Observable("")
    var isValid: Observable<Bool> = Observable(false)
    
    func checkValidation() {
        let select = (email.value.count >= 6 && password.value.count >= 4 ) ? true : false
        isValid.value = select
    }
    func signIn(completion: @escaping () -> Void) {
        UserDefaults.standard.set(name.value, forKey: "name")
        completion()
    }
}