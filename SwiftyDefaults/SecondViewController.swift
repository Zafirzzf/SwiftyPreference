//
//  SecondViewController.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2020/1/8.
//  Copyright © 2020 周正飞. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var personObservation: ObservationRemovable?
    
    deinit {
        print("销毁2")
    }
    var observation: ObservationRemovable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        observation = DefaultsConfig.$animal.observe { (newAnimal) in
            print(newAnimal.name, "secondviewcontroller")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}
