//
//  ViewController.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2019/6/26.
//  Copyright © 2019 周正飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var personObservation: NSObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DefaultsConfig.person = Person()
        personObservation = DefaultsConfig.$person.observe { (new) in
            print("收到变更: ", new)
        }
        DefaultsConfig.person = Person(name: "asdf", age: 1, height: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            DefaultsConfig.person = Person(name: "asdf", age: 1, height: 1)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        present(SecondViewController(), animated: true, completion: nil)
    }
}

