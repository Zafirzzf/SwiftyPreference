//
//  ViewController.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2019/6/26.
//  Copyright © 2019 周正飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = Defaults[.name]
        print(value)
        // please review in SwiftyDefaultsTests.swift
    }
}

