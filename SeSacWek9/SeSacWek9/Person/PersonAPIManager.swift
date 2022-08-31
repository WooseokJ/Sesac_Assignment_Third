//
//  PersonAPIManager.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    static func requestPerson(query: String, completion: @escaping (Person?, APIError?) -> Void) {
//        query.addingPercentEncoding(withAllowedCharacters: <#T##CharacterSet#>) //한글입력시 처리
        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=f489dc25fbe453f2a6afaf7b182defd5&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.thmoviedb.org" //공통영역
        let path = "/3/search/person" //세부항목
        let language = "ko-KR"
        let key = "f489dc25fbe453f2a6afaf7b182defd5"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language),
            
        ]
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
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    completion(result,nil)
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }
}
