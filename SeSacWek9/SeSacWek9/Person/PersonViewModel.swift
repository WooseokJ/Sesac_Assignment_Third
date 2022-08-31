//
//  PersonViewModel.swift
//  SeSacWek9
//
//  Created by useok on 2022/08/31.
//

import Foundation

class PersonViewModel {
    
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: "kim") { person, error in
            guard let person = person else {
                return
            }
            self.list.value = person
            // self.list는 observable<person>
            // self.list.value 는 person
        }
    }
    
    var numberOfRowsInSection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
    
    
    
    
    
}
