//
//  Observale.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/31.
//

import Foundation

class Observable<T> { //양방향 바인딩   어려우면 T는 INT라고생각하고 보자
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset실행됨.",value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T)->Void) {
        closure(value)
        listener = closure
    }
    
}

class User {
        
    private var listener: ((String) -> Void)?
    
    var value: String {
        didSet {
            print("데이터 바뀜")
            listener?(value)
        }
    }
    init(_ value: String) {
        self.value = value
    }
}
