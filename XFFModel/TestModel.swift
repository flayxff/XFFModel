//
//  TestModel.swift
//  Test
//
//  Created by 吴垠锋 on 2019/8/13.
//  Copyright © 2019 吴垠锋. All rights reserved.
//

import Foundation

class TestModel: NSObject {
    
    @objc var name = ""
    @objc var age = 0
    @objc var isMerry = false
    @objc var tools = [String]()
    @objc var pet = [String : Any]()
    @objc var books = [Book]()
    @objc var phone = Phone()
    
}
