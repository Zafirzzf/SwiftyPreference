//
//  SecondViewController.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2020/1/8.
//  Copyright © 2020 周正飞. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var personObservation: NSObject?
    
    deinit {
        print("销毁2")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        DefaultsConfig.person = Person()
        personObservation = DefaultsConfig.$person.observe { (new) in
            print("收到变更2: ", new)
        }
        DefaultsConfig.person = Person(name: "asdf", age: 3, height: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}
