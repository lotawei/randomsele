//
//  ViewController.swift
//  抽奖模块开发
//
//  Created by lotawei on 16/9/14.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ClickBtnPro {
    var   getwards:UILabel!
    var   random:RandombounceView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let   fa = CGRectMake(30,100 , 300, 300)
        random = RandombounceView(frame:fa )
        self.view.addSubview(random)
        random.sd_layout().centerXEqualToView(self.view).topSpaceToView(self.view,100
        )
        random.delegate = self
        getwards = UILabel()
        getwards.textAlignment  = .Center
        self.view.addSubview(getwards)
        getwards.sd_layout().widthIs(200).heightIs(40).centerXEqualToView(self.view).topSpaceToView(self.random,70)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func transportresult(reslut: String) {
        getwards.text = reslut
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

