//
//  InstantiatableExtension.swift
//  RxSwiftTraining
//
//  Created by 鈴木 公章 on 2020/05/29.
//  Copyright © 2020 kimioman. All rights reserved.
//

import UIKit

extension Instantiatable {
    public static var storyboardName: String {
        String(describing: self)
    }

    public static var bundle: Bundle? {
        Bundle(for: self)
    }
}

extension Instantiatable where Self: UIViewController {
    public static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardName) as! Self
    }
}
