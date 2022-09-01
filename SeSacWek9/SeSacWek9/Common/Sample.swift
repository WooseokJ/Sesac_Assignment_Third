//
//  Sample.swift
//  SeSacWek9
//
//  Created by useok on 2022/09/01.
//

import Foundation

class UserSample {
    private var listener: () -> Void = {
//        o, n in
//        print("name 바뀜: \(o) -> \(n)")
        print("QQQ")
    }
    
    
    
    var name: String {
        didSet {
//            listener(oldValue, name)
            listener()
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func nameChanged(com: @escaping () -> Void) {
        com() // name changed Func     or a changed Func
                    //        {
                    //            print("name chaged Func ")
                    //        }
        
        listener = com // 클로더 구문 업데이트     QQQ 대신 com(name changed Func / a changed Func)이 들어감.그래서 qqq실행 x
    }
}
