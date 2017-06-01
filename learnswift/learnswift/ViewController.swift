//
//  ViewController.swift
//  learnswift
//
//  Created by apple on 17/5/24.
//  Copyright © 2017年 ss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("hello,world")
       
        let nim = 20
        print(nim)
        var varnum = 0
        
        var num1 = 1, num2 = 2
        let num3 = 1, num4 = 2
        
        var str: String
        var str1, str2, str3: String
        
        let 你好 = "你好"
        let π = 3.14159
        
        varnum = 10
        
//        num3 = 10 常量的值不可以改变
        print("hi",terminator:"")  //terminator:"" 去掉了结尾的换行
        print("hello,world")

        print("hi",separator:"1",terminator: "!")
        print("hello,world!")
        
        print("hi\(你好) \(π)")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

