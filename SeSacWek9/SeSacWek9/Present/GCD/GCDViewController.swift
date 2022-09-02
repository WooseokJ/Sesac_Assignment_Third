//
//  GCDViewController.swift
//  SeSacWek9
//
//  Created by useok on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: 결론: 우리는 main/async와 global/sync(동기)만 사용할거! 2,3번
    
    //MARK: main/sync(동기)
    @IBAction func SerialSync(_ sender: UIButton) {
        print("start",terminator: " ")
        for i in 1...100 {
            print(i, terminator: " ")
        }
        //main/sync(동기)은  아래와같이쓸일없음.
        /*
         DispatchQueue.main.sync { // 무한대기상태(교착상태(deadlock))   오류나옴
            for i in 101...200 {
                print(i,terminator: " ")
            }
        }*/
        
        for i in 101...200 {
            print(i,terminator: " ")
        }
        print("end")
    }
    //MARK: main/async(비동기)
    @IBAction func serialAsync(_ sender: UIButton) {
        print("start",terminator: " ")
        // 시도1
//        DispatchQueue.main.async { // 101~200 end 1 ~100
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        // 시도2 (시도1과 차이없음)
        for i in 1...100 {
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
     
        for i in 101...200 {
            print(i,terminator: " ")
        }
        print("end")
    }
    //MARK: global/sync(동기)
    @IBAction func globalSync(_ sender: UIButton) {
        print("start",terminator: " ")
        // 시도1
//        DispatchQueue.global().sync { // 1~100 101~200 end
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        // 시도2 (시도1과 차이없음)
        for i in 1...100 {
            DispatchQueue.global().sync {
                print(i, terminator: " ")
            }
        }
     
        for i in 101...200 {
            print(i,terminator: " ")
        }
        print("end")
    }
    //MARK: global/async(비동기)
    @IBAction func globalAsync(_ sender: UIButton) {
        print("start",terminator: " ")
        // 시도1
//        DispatchQueue.global().async { // 101 1 102 103 104 2 105 ~~ end 43~100 섞여서 찍혀
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        // 시도2 (시도1과 차이가있음)    1~100사이 랜덤  101~~200 랜덤 출력 end
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
     
        for i in 101...200 {
            print(i,terminator: " ")
        }
        print("end")
    }
    //MARK: GCD Qos(Quality Of Service)
    @IBAction func qos(_ sender: UIButton) {
    }
}
