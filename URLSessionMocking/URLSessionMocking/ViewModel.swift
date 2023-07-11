//
//  ViewModel.swift
//  URLSessionMocking
//
//  Created by Harish on 11/07/23.
//

import Foundation

class ViewModel {
    // Binding using Closure
    var namesUpdateClosure: (([String]) -> Void)?
    
    // Binding using Combine
    @Published var dataLoading = false
    
    var names: [String] = [] {
        didSet {
            namesUpdateClosure?(names)
        }
    }
    
    func loadNames() {
        let dispatchQueueBackground = DispatchQueue.global(qos: .background)
        dataLoading = true
        dispatchQueueBackground.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
                self?.names = ["Harry", "Emma", "Ronald"]
                self?.dataLoading = false
            })
        }
    }
    
}
