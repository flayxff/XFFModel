//
//  ViewController.swift
//  XFFModel
//
//  Created by 吴垠锋 on 2019/8/13.
//  Copyright © 2019 吴垠锋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = TestModel()
    var models = [TestModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func dictTransitionToModel(_ sender: UIButton) {
        if let path = Bundle.main.path(forResource: "Test", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let result = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                
                // 这个demo是字典
                
                // json如果是字典
                if let dict = result as? [String : Any] {
                    model = getDataDictWith(dict: dict)
                }
                
                // json如果是数组
//                if let array = result as? [[String : Any]] {
//                    model = getDataArrayWith(array: array)
//                }
                
                printModel()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func modelTransitionToDict(_ sender: UIButton) {
        
        // 这个demo是字典
        
        // 如果是字典转成json
        let dict = getDictWith(obj: model)
        print(dict)
        
        // 如果是数组转成json
//        let array = getArrayWith(array: models)
//        print(array)
    }
    
    func printModel()  {
        print(model.name)
        print(model.age)
        print(model.isMerry)
        print("--------")
        print(model.tools)
        print("--------")
        print(model.pet)
        for book in model.books {
            print("--------")
            print(book.title)
            print(book.author)
        }
        print("--------")
        print(model.phone.brand)
        print(model.phone.name)
        print(model.phone.price)
        print(model.phone.isOld)
    }
    
}

