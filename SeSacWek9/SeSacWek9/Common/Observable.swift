//
//  Observale.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/31.
//

import Foundation

class Observable<T> { //양방향 바인딩   어려우면 T는 INT라고생각하고 보자
    
    private var listener: ((T) -> Void)?
    
    var value: T { //model
        didSet { // viewModel
//            print("didset실행됨.",value)
            listener?(value)  // value(데이터)바뀌면 -> listener(화면뷰)가 label.text 바뀌게됨. , 처음엔 listener에 nil 이다가 bind이 되면 tableview.reloadData()라는 로직이 listener에 들어감
            
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ com: @escaping (T)->Void) {
//        com(value) // T 에 value 들어가서 void 반환 
        listener = com // com함수의 로직자체를 담는다. , ex) label.text = value 이거자체  ,    self.tableView.reloadData()이 listener에 들어간거, com

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
    
    func bind(_ com: @escaping (String) -> Void) {
        com(value)    //{ name in
                    //        print("\(name) 으로 바뀜")
                    //    }
        listener = com
    }
    
}
