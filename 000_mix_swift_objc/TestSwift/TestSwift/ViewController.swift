//
//  ViewController.swift
//  TestSwift
//
//  Created by Jason Li on 6/3/14.
//  Copyright (c) 2014 swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var note = Note()
        note.log()
        note.attachBook()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

