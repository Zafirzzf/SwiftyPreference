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
    
    deinit {
        observation = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observation = DefaultsConfig.$animal.observe { (newAnimal) in
            print(newAnimal.name)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        present(SecondViewController(), animated: true, completion: nil)
    }
}

