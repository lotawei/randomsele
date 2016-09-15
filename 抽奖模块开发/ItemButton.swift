//
//  ItemButton.swift
//  抽奖模块开发
//
//  Created by lotawei on 16/9/14.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class ItemButton: UIButton {

    var   jifenlable:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         jifenlable =  UILabel()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = 5.0
       
        
        jifenlable.textAlignment = .Center
        jifenlable.font = UIFont.systemFontOfSize(15)
        jifenlable.textColor = UIColor.redColor()
        self.addSubview(jifenlable)
        titleLabel?.font = UIFont.systemFontOfSize(15)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    override   func layoutSubviews() {
          super.layoutSubviews()
        
          jifenlable.sd_layout().widthIs(50).heightIs(30).topSpaceToView(self,2).leftSpaceToView(self,1)
    }
   
}
