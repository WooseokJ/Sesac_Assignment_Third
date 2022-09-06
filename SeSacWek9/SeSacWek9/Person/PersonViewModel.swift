//
//  PersonViewModel.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/31.
//

import Foundation

class PersonViewModel {
    
    
    
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: [])) //데이터
    
    func fetchPerson(query: String) { // 로직
        PersonAPIManager.requestPerson(query: "kim") { person, error in
            guard let person = person else {
                return
            }
            self.list.value = person //person은 데이터 
            // self.list는 observable<person>
            // self.list.value 는 person
        }
    }
    
    var numberOfRowsInSectionJack: Int { // 로직 , get방식
        return list.value.results.count
    }
    
    func cellForRowAtJack(at indexPath: IndexPath) -> Result { // 로직, get방식
        return list.value.results[indexPath.row]
    }
    
    
    
    
    
}
