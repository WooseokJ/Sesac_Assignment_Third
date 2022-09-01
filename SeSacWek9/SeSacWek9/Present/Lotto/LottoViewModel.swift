//
//  LottoModel.swift
//  SeSacWek9
//
//  Created by useok on 2022/09/01.
//

import Foundation

class LottoViewModel {
    var num1 = Observable(1)
    var num2 = Observable(2)
    var num3 = Observable(3)
    var num4 = Observable(4)
    var num5 = Observable(5)
    var num6 = Observable(6)
    var num7 = Observable(7)
    var lottoDate = Observable("날짜")
    var lottoMoney = Observable("당첨금")
    
    func format(for num: Int) -> String {
        let numFormat = NumberFormatter()
        numFormat.numberStyle = .decimal
        guard let stringNum = numFormat.string(for: num) else {return ""}
        return stringNum
    }
    
    
    func fetchLottoAPI(drwNo: Int) {
        LottoAPIManager.requestLott(drwNo: drwNo) { lotto, error in
            guard let lotto = lotto else {
                return
            }
            self.num1.value = lotto.drwtNo1
            self.num2.value = lotto.drwtNo2
            self.num3.value = lotto.drwtNo3
            self.num4.value = lotto.drwtNo4
            self.num5.value = lotto.drwtNo5
            self.num6.value = lotto.drwtNo6
            self.num7.value = lotto.drwNo
//            self.lottoDate.value = lotto.totSellamnt
//            self.lottoMoney.value = lotto.totSellamnt // 1,234,234,324,000 ,로 구분해줘야함
            self.lottoMoney.value = self.format(for: lotto.totSellamnt)
        }
    }
    
}
