//
//  ViewController.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet{ // 데이터 바인딩 이라부름.
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var lottoLabel: UILabel!
    
    private var viewModel = PersonViewModel()
    
//    var list: Person? = Person(page: 0, totalPages: 0, totalResults: 0, results: []) {
//        didSet{
//            tableView.reloadData()
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        LottoAPIManager.requestLott(drwNo: 1011) { lotto, error in
//            guard let lotto = lotto else {
//                return
//            }
//
//            self.lottoLabel.text = lotto.drwNoDate
//        }
//
//        PersonAPIManager.requestPerson(query: "kim") { person, error in
//            guard let person = person else {
//                return
//            }
//            self.list = person
//            self.tableView.reloadData()
//        }
        
        viewModel.fetchPerson(query: "kim") //didset실행됨
        viewModel.list.bind { Person in //VC bind
            print("VC bind")
            self.tableView.reloadData()
        }
        
        //MARK: 테스트겸
//        var num1 = 10
//        var num2 = 3
//        print(num1-num2)
//        num1 = 3
//        // num1,num2의 값이 계속바뀔떄마다 프린트찍으려면 어떻게해야될까?
//        var num3 = Observable(10)
//        var num4 = Observable(3)
//
//        num3.bind { a in
//            print("observable", num3.value - num4.value)
//        }
//        print("=====================1")
//        num3.value = 100
//        print("=====================2")
//        num3.value = 200
//        print("=====================6")
        
        //MARK: Sample 예제
//        let user = UserSample(name: "가가")
//        user.nameChanged {
//            print("name chaged Func ")
//        }
//        print("=====================7")
//        let a = UserSample(name: "aa")
//        a.nameChanged {
//            print("a chagend")
//        }
//        
//        print("=====================3")
//        user.name = "나나"
//        print("=====================4")
//        user.name = "다다"
//        print("=====================5")
        //MARK: user 예제
        let example = User("가가")
        example.value = "나나"
        print("=====================8")
        example.bind { name in
            print("\(name) 으로 바뀜")
        }
        print("=====================9")
        let sample = Observable([1,2,3])
        sample.bind { value in
            print(value)
        }
        
        
//        
        
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list?.results.count ?? 0 //list가 nil이면 0으로 안됨.
        return viewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = list?.results[indexPath.row].knwonForDepartment
        
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knwonForDepartment
        
        
        return cell
    }
    
}

