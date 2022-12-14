//
//  LottoAPIManager.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/30.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}


class LottoAPIManager {
    static func requestLott(drwNo: Int, completion: @escaping (Lotto?,APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        //shared - 단순한,커스텀x,응답클로저,
        
//        let a = URLRequest(url: url)
//        a.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        
        /**
         URLSession.shared.dataTask
         - with: 어디에 보낼래? url주소 넣기
         - completionHandler: 네트워크 통신시 3가지 값(data,response,error)을 받는다.
         */
        
        URLSession.shared.dataTask(with: url)  { data, response2, error in // 셋중하나는 nil이 된다.
            DispatchQueue.main.async {
                guard error == nil else { //에러있는지
                    print("failed request")
                    completion(nil, .failedRequest)
                    return
                }
                guard let data = data else { //데이터에 문제있는지 ,json이 잘왓는지
                    print("no data returned")
                    completion(nil, .noData)
                    return
                }
                guard let response3 = response2 as? HTTPURLResponse else {
                    print("unable response")
                    completion(nil,.invalidResponse)
                    return
                }
                guard response3.statusCode == 200 else {
                    print("failed response")
                    completion(nil,.failedRequest)
                    return
                }
                
                //문제없으면
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    completion(result,nil)
                } catch {
                    print(error)
                }
            }
            
            
           
            
        }.resume() // resume()은 일시정지해서 보내달라
        
        // defauilt-configuration - shared 설정유사, 커스텀 O(셀룰러연결여부,백그라운드상태에서 음악재생,다운로드등) , 응답클로저+딜리게이트
        // URLSession.init(configuration: . )
        
    }
}
