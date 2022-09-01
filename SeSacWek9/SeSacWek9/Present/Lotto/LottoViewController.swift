//
//  LottoViewController.swift
//  SeSacWek9
//
//  Created by useok on 2022/09/01.
//

import UIKit

class LottoViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+3) { //3초후 1000회차
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+8) { //8초후 1022회차
            self.viewModel.fetchLottoAPI(drwNo: 1022)
        }
        bindData()
    }
    func bindData() {
        viewModel.num1.bind {self.label1.text = "\($0)"}
        viewModel.num2.bind {self.label2.text = "\($0)"}
        viewModel.num3.bind {self.label3.text = "\($0)"}
        viewModel.num4.bind {self.label4.text = "\($0)"}
        viewModel.num5.bind {self.label5.text = "\($0)"}
        viewModel.num6.bind {self.label6.text = "\($0)"}
        viewModel.num7.bind {self.label7.text = "\($0)"}
        viewModel.lottoMoney.bind { money in
            self.dateLabel.text = money
        }
        
    }
    


}
