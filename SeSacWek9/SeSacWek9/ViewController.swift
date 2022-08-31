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
        
        viewModel.fetchPerson(query: "kim")
        viewModel.list.bind { Person in
            print("VC bind")
            self.tableView.reloadData()
        }
        
        
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

