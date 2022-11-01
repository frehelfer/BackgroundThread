//
//  ViewModel.swift
//  BackgroundThread
//
//  Created by Frédéric Helfer on 01/11/22.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        // Background Thread
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            // Sempre que for modificar a mainView, precisa usar a main thread!
            // Ou seja, após carregar os dados, alterar a a view na main thread.
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
            }
        } 
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<1000 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
}
