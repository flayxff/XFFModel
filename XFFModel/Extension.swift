//
//  Extension.swift
//  Test
//
//  Created by 吴垠锋 on 2019/8/13.
//  Copyright © 2019 吴垠锋. All rights reserved.
//

import Foundation

extension NSObject {
    
    func setValuesForKeys(_ keyedValues: [String : Any]) {
        for (key, value) in keyedValues {
            setCustomValue(value, forKey: key)
        }
    }
    
    private func setCustomValue(_ value: Any?, forKey key: String) {
        if let dict = value as? [String : Any] {
            if let objClass = getClassWith(key) as? NSObject.Type {
                let model = objClass.init()
                model.setValuesForKeys(dict)
                setValue(model, forKey: key)
                return
            }
        } else if let array = value as? [[String : Any]] {
            if let objClass = getClassWith(key, isArray: true) as? NSObject.Type {
                var resultArray = [NSObject]()
                for dict in array {
                    let model = objClass.init()
                    model.setValuesForKeys(dict)
                    resultArray.append(model)
                }
                setValue(resultArray, forKey: key)
                return
            }
        }
        setValue(value, forKey: key)
    }
    
    private func getClassWith(_ key: String, isArray: Bool = false) -> AnyClass? {
        let mirror = Mirror(reflecting: self)
        let children = mirror.children.filter { (child) -> Bool in
            return child.label == key
        }
        if let value = children.first?.value {
            var valueType = "\(Mirror(reflecting: value).subjectType)"
            if isArray {
                valueType = valueType.replacingOccurrences(of: "Array<", with: "")
                valueType = valueType.replacingOccurrences(of: ">", with: "")
            }
            if let projectName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
                return NSClassFromString(projectName + "." + valueType)
            }
        }
        return nil
    }
    
}
