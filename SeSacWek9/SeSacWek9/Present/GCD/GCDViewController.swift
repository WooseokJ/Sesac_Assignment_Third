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
    //MARK: 결론: 우리는 main/async와 global/async(비동기)만 사용할거! 2,4번
    // main/async 는 ui다룰떄 사용
    // global/async는 네트워크통신떄사용
    
    //MARK: main/sync(동기)
    @IBAction func SerialSync(_ sender: UIButton) {
        print("start",terminator: " ")
        for i in 1...100 {
            print(i, terminator: " ")
        }
        //main/sync(동기)은  아래와같이쓸일없음.
        
         DispatchQueue.main.sync { // 무한대기상태(교착상태(deadlock))   오류나옴, 101~200을 작업이끝날떄까지 기다려야하는데 자기가 기다려야함.근데 또 자기가 작업이끝날떄까지 기다려야하는 무한대기상태가됨.
            for i in 101...200 {
                print(i,terminator: " ")
            }
        }
        
        print("end")
    }
    //MARK: main/async(비동기)
    @IBAction func serialAsync(_ sender: UIButton) {
        print("start",terminator: " ")
        // 시도1
        DispatchQueue.main.async { // 101~200 end 1 ~100
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        // 시도2 (시도1과 차이없음)
//        for i in 1...100 {
//            DispatchQueue.main.async {
//                print(i, terminator: " ")
//            }
//        }
     
        for i in 101...2000 {
            print(i,terminator: " ")
        }
        
        
        
        
        //만약에 화면전환시 네트워크 통신이 끝나야지만 화면이 넘어가게 구현할꺼면?
        /*
         
         네트워크 통신되는코드~
         
         마지막부분에
         dispathQueue.main.async { // main에서 sync는 쓸수없고 main에서 ui적인 처리떄문에 main에서 그려야함., 쉽게생각하면 함수안의 모든줄이끝나고 마지막에 실행됨.
            presnet(vc,animate = ture)
         }
         추가 하면됨.
         
         
         */
        print("end")
    }
    //MARK: global/sync(동기)
    @IBAction func globalSync(_ sender: UIButton) {
        print("start \(Thread.isMainThread)",terminator: " ")
        // 시도1
        DispatchQueue.global().sync { // 1~100 101~200 end ,   global이 작업이 작업이 끝날떄까지 main은 기다려야하므로 main이 동기로 작업하는것과 유사
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        // 시도2 (시도1과 차이없음)
//        for i in 1...100 {
//            DispatchQueue.global().sync {
//                print(i, terminator: " ")
//            }
//        }
     
        for i in 101...200 {
            print(i,terminator: " ")
        }
        print("end \(Thread.isMainThread)")
    }
    //MARK: global/async(비동기)
    @IBAction func globalAsync(_ sender: UIButton) {
        print("start",terminator: " ")
        // 시도1
        DispatchQueue.global().async { // 101 1 102 103 104 2 105 ~~ end 43~100 섞여서 찍혀
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        // 시도2 (시도1과 차이가있음)    1~100사이 랜덤  101~~200 랜덤 출력 end
//        for i in 1...100 {
//            DispatchQueue.global().async {
//                print(i, terminator: " ")
//            }
//        }
     
        for i in 101...200 {
            print(i,terminator: " ")
        }
        print("end")
    }
    
    
    
    
    
    
    
    
    
    //MARK: GCD Qos(Quality Of Service) 우선순위 서비스
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
        
        // 시도2 (global 안에서도 우선쉬위를 부여 )
         // 특정업무에 네이밍붙임(label), qos는 우선순위 설정 attribute 는 큐의종류중하나
        //큐의 종류: concurrent, serial, customqueue

        let customQueue = DispatchQueue(label: "concurrentSeSac",qos: .userInteractive, attributes: .concurrent)
        
        
        customQueue.async {
            print("start")
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
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async { // 우선순위 늦음
            print(i,terminator: " ")
            }
        }
    }
    //MARK: DispatchGroupNASAButton의 원리
    @IBAction func dispatchGroupButton(_ sender: UIButton) {
        let group2 = DispatchGroup() //통신1,2,3이 기록됨.
        
        DispatchQueue.global().async(group: group2) { //통신1
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group2) { //통신2
            for i in 100...200 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group2) { //통신3
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        group2.notify(queue: .main){ // group2(통신1,2,3 를뜻하고 이를 dispatchGroup이라부름)이 다 끝나면 실행 (단 네트워크는 다름)
            print("끝") // tableview.reload
        }
    }
    @IBAction func DispatchGroupNASAButton(_ sender: UIButton) {
        // 시도1 3 1 2 로 순서 뒤죽 박죽
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
        
        //시도2   1,2,3,끝 순서대로 이지만 오래걸려
        /*
        request(url: url1) { image in
            print("1")
            self.request(url: self.url2) { image in // 첫번쨰 url1이 끝나야 동작시작
                print("2")
                self.request(url: self.url3) { image in // url2가 끝나야 동작시작
                    print("3")
                    print("끝") // tableview.reload
                }
            }
        } */
        
        //시도3  끝 3  1 2
        let group2 = DispatchGroup()
        DispatchQueue.global().async(group: group2) { //비동기1
            self.request(url: self.url1) { image in
                print("1")
            }
            
            //위 self.request(url: self.url1) 함수호출
//            URLSession.shared.dataTask(with: url) { data, response, error in  //여기서도 비동기2 위에비동기1이랑 다른역할
//                guard let data = data else {
//                    completionHandler(UIImage(systemName: "star"))
//                    return
//                }
//
//                let image = UIImage(data: data)
//                completionHandler(image)
//
//            }.resume() //resume() 보낸다.   , 이는 비동기2라서 처리가안끝냈지만 처리가 끝낫다고 main쓰레드에게 알려서 메인쓰레드는 끝낫다고 생각함.
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
        group2.notify(queue: .main){ // 끔, 3,1,2
            print("끝") // tableview.reload
        }
    }
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
    
    
    @IBAction func english(_ sender: UIButton) {
        let group2 = DispatchGroup()
        DispatchQueue.global().async(group: group2) { // 끝312 로실행,  네트워크 끝나야 notify실행
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
        group2.notify(queue: .main){
            print("끝") // tableview.reload
        }
    }
    
    func a() {
        let group = DispatchGroup()
        DispatchQueue.global().async(group: group) { // 비동기라도 순서대로 1...300 이 나옴
            for i in 1...100{print(i, terminator: " ")}
            for i in 101...200{print(i,terminator: " ")}
            for i in 201...300{print(i,terminator: " ")}
        }
    }
    func b() {
        let group = DispatchGroup()
        DispatchQueue.global().async(group: group) { // 201...300/1...100/101...200
            for i in 1...100{print(i, terminator: " ")}
        }
        DispatchQueue.global().async(group: group) { //
            for i in 101...200{print(i,terminator: " ")}
        }
        DispatchQueue.global().async(group: group) { //
            for i in 201...300{print(i,terminator: " ")}
        }
    }
    
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group2 = DispatchGroup()
        var imageList: [UIImage] = [] //
        
        group2.enter() // 그룹2에 아래내용을 추가하겟다 RC 1
        request(url: url1) { image in //
            print("1")
            imageList.append(image!)
            group2.leave() // 다끝나면 그룹을 떠난다 RC 0
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
        
        group2.notify(queue: .main) { // 이렇게하면 group2가 완전히 끝나면 이미지가 보여짐
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
            nickname = "1"  // +10
            print("first:",nickname)
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group2) {
            nickname = "2" // *3
            print("second:",nickname)
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group2) {
            nickname = "3" // -2
            print("third:",nickname)
        }
        group2.notify(queue: .main) { // second, result,third, first 랜덤. 현재 3개의 global이 하나의 nickname을 가리키므로 문제! 연산같은경우 순서에따라 값이달라짐
            print("result:",nickname) // ?? 어떤값이 나올지 예상안됨.
        }
    }
}
