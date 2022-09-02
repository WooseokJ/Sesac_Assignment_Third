//
//  GCDViewController.swift
//  SeSacWek9
//
//  Created by useok on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {
    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var imageSecond: UIImageView!
    @IBOutlet weak var imageThird: UIImageView!
    
    //MARK: 네트워크통신
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
        let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
        let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!

    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
            //아래부분이 global로 동작한다.
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completionHandler(UIImage(systemName: "star"))
                    return
                }

                let image = UIImage(data: data)
                completionHandler(image)
                                      
            }.resume()
        }
    
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
        //시도1
        /*
        DispatchQueue.global(qos: .background).async { // 우선순위 늦음
            for i in 1...100 {
                print(i,terminator: " ")
            }
        }
        
        
        DispatchQueue.global(qos: .userInteractive).async {  // 우선순위높음
            for i in 101...200 {
                print(i,terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .utility).async { // 우선순위 중간 ,참고로 default는 일반 , unspecitied는 사용안함.
            for i in 201...300 {
                print(i,terminator: " ")
            }
        }*/
        
        // 시도2
        let customQueue = DispatchQueue(label: "concurrentSeSac",qos: .userInteractive, attributes: .concurrent)
        customQueue.async {
            print("start")
        }
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async { // 우선순위 늦음
            print(i,terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async {  // 우선순위높음
            print(i,terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async { //우선순위 중간
            print(i,terminator: " ")
            }
        }
    }
    //MARK: 원리
    @IBAction func dispatchGroupButton(_ sender: UIButton) {
        let group2 = DispatchGroup()
        
        DispatchQueue.global().async(group: group2) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group2) {
            for i in 100...200 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group2) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        group2.notify(queue: .main){ // group2가 다끝나면 실행
            print("끝") // tableview.reload
        }
    }
    @IBAction func DispatchGroupNASAButton(_ sender: UIButton) {
        // 시도1 3 1 2 로 순서뒤죽박죽
        /*
        request(url: url1) { image in
            print("1")
        }
        request(url: url2) { image in
            print("2")
        }
        request(url: url3) { image in
            print("3")
        }
        print("끝") // tableview.reload
        */
        
        //시도2   1,2,3 순서대로 이지만 오래걸려
        /*
        request(url: url1) { image in
            print("1")
            self.request(url: self.url2) { image in
                print("2")
                self.request(url: self.url3) { image in
                    print("3")
                    print("끝") // tableview.reload
                }
            }
        } */
        
        //시도3  3  1 2
        let group2 = DispatchGroup()
        DispatchQueue.global().async(group: group2) {
            self.request(url: self.url1) { image in
                print("1")
            }
        }
        
        DispatchQueue.global().async(group: group2) {
            self.request(url: self.url2) { image in
                print("2")
            }
        }
        
        DispatchQueue.global().async(group: group2) {
            self.request(url: self.url3) { image in
                print("3")
            }
        }
        group2.notify(queue: .main){ // group2가 다끝나면 실행
            print("끝") // tableview.reload
        }
    }
    
    @IBAction func a(_ sender: UIButton) {
        let group2 = DispatchGroup()
        DispatchQueue.global().async(group: group2) { // 312 끝 로 네트워크 끝나야 notify실행
            self.request(url: self.url1) { image in
                print(1)
            }
            self.request(url: self.url2) { image in
                print(2)
            }
            self.request(url: self.url3) { image in
                print(3)
            }
        }
        group2.notify(queue: .main){ // group2가 다끝나면 실행
            print("끝") // tableview.reload
        }
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group2 = DispatchGroup()
        var imageList: [UIImage] = []
        group2.enter()
        request(url: url1) { image in
            print("1")
            imageList.append(image!)
            group2.leave()
        }
        
        group2.enter()
        request(url: url2) { image in
            print("2")
            imageList.append(image!)
            group2.leave()
        }

        group2.enter()
        request(url: url3) { image in
            print("3")
            imageList.append(image!)
            group2.leave()
        }
        group2.notify(queue: .main){ // group2가 다끝나면 실행
//            print("끝") // tableview.reload
            self.imageFirst.image = imageList[0]
            self.imageSecond.image = imageList[1]
            self.imageThird.image = imageList[2]
        }
    }
    
    @IBAction func raceConfition(_ sender: UIButton) {
        let group2 = DispatchGroup()
        var nickname = "seSac"
        DispatchQueue.global(qos: .userInteractive).async(group: group2) {
            nickname = "고래밥"
            print("first:",nickname)
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group2) {
            nickname = "칙촉"
            print("second:",nickname)
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group2) {
            nickname = "울라프"
            print("third:",nickname)
        }
        group2.notify(queue: .main) {
            print("result:",nickname)
        }
    }
}
