//
//  ViewController.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2019/6/26.
//  Copyright © 2019 周正飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var observation: ObservationRemovable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observation = DefaultsConfig.$token.observe { (token) in
            print(token)
        }
    }
}

