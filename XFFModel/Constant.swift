//
//  Constant.swift
//  XFFModel
//
//  Created by 吴垠锋 on 2019/8/13.
//  Copyright © 2019 吴垠锋. All rights reserved.
//

import Foundation

func getDataArrayWith<T: NSObject>(array: [[String : Any]]) -> [T] {
    var resultArray = [T]()
    for dict in array {
        let model = T()
        model.setValuesForKeys(dict)
        resultArray.append(model)
    }
    return resultArray
}

func getDataDictWith<T: NSObject>(dict: [String : Any]) -> T {
    let model = T()
    model.setValuesForKeys(dict)
    return model
}

func getDictWith(obj: Any) -> [String : Any] {
    var dict = [String : Any]()
    let mirror = Mirror(reflecting: obj)
    for item in mirror.children {
        guard let key = item.label else {
            continue
        }
        let value = item.value
        if let array = value as? [Any] {
            dict.updateValue(getArrayWith(array: array), forKey: key)
        } else if isModelWith(value) {
            dict.updateValue(getDictWith(obj: value), forKey: key)
        } else {
            dict.updateValue(value, forKey: key)
        }
    }
    return dict
}

func getArrayWith(array: [Any]) -> [Any] {
    var resultArray = [Any]()
    guard let first = array.first else {
        return array
    }
    if isModelWith(first) {
        for obj in array {
            let dict = getDictWith(obj: obj)
            resultArray.append(dict)
        }
        return resultArray
    } else {
        return array
    }
}

func isModelWith(_ value: Any) -> Bool {
    let valueType = "\(Mirror(reflecting: value).subjectType)"
    if let projectName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
        return NSClassFromString(projectName + "." + valueType) != nil
    }
    return false
}
