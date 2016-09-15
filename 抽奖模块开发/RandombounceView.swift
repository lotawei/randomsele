//
//  RandombounceView.swift
//  抽奖模块开发
//
//  Created by lotawei on 16/9/14.
//  Copyright © 2016年 lotawei. All rights reserved.
//


//需要实现的效果呢是怎样的   －－－
                    //   －bt－
                    //   －－－
    //中间是个按钮

//0    x = ox  y = ox  0
//1    x = ox + xpading + w   1
//2    x = ox + 2*(xpading + w)   2
//3    实际是第5个的位置
//4    实际是第8个的位置
//5    实际是第7个的位置
//6    实际是第6个位置
//7    实际是 3 的位置    //对于这种没有什么规律的做成字典比较合适
protocol   ClickBtnPro{
      func  transportresult(reslut:String)
}



class RandombounceView: UIView {
    
    
    
    private   let   result = ["电视机","洗衣机","送学姐","想多了","抽奖","送学妹","送学长","谢谢光临","电影劵"]
    private   let  adic = [0:"0",1:"1",2:"2",3:"5",4:"8",5:"7",6:"6",7:"3"]
    private  let  xpading:CGFloat  = 1
    private  let  ypadding:CGFloat =  1
    private  let  ox:CGFloat = 8
    
    
    //背景图
    lazy  var    itemop:NSMutableArray =  {
        let   itemop  = NSMutableArray(capacity:0)
        for i in  0..<9{
            let   str = String(format:"img%d" , i)
            let   img = UIImage(named: str)
            itemop.addObject(img!)
        }
        return  itemop
    }()
    //当前选择项
    private  var  selectindex:NSInteger  = 0
    
    private  var  alayer:CAShapeLayer!
    
    var   btns : NSMutableArray = {
        let   btns  =  NSMutableArray(capacity:0)
        return  btns
    }()
    
   private var     itemquare:CGFloat = 0.0
       var  delegate:ClickBtnPro?
    
    //学点新的试试 
    private   var   gametime:NSTimer!
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        gametime = NSTimer(timeInterval: 0.6, target: self, selector: #selector(updatedisplay), userInfo: nil, repeats: true)
         NSRunLoop.mainRunLoop().addTimer(gametime, forMode: NSDefaultRunLoopMode)
        
        
        backgroundColor = UIColor.grayColor()
        itemquare = (300 - (2 * xpading) - (2 * ox))/3
        for i in 0..<9 {
            let   abtn = ItemButton(type:.Custom)
            if i == 4 {
                
                abtn .setTitleColor(UIColor.blackColor(), forState: .Normal)
                abtn .backgroundColor = UIColor.redColor()
                abtn.addTarget(self, action: #selector(yaoyiyao), forControlEvents: .TouchUpInside)
                abtn.setBackgroundImage(UIImage(named: "0"), forState: .Highlighted)
                
            }
            else{
            abtn.jifenlable.text =  "10"
            abtn.setBackgroundImage(self.itemop[i] as? UIImage, forState: .Normal)
            abtn.imageView?.contentMode = .ScaleAspectFit
            abtn.setTitle(self.itemop[i] as? String, forState: .Normal)
           
                abtn.userInteractionEnabled =  false
                
            }
            abtn .setTitle(result[i], forState: .Normal)
            abtn.tag =  i + 1000
            self.btns.addObject(abtn)
            self.addSubview(abtn)
           
            
          
        }
       
        
        
    }
    func selectitem(index:NSInteger) {
        // 为当前图层创建一个阴影效果的蒙板
        if alayer !=  nil {
            alayer.removeFromSuperlayer()
        }
        
       
        alayer = CAShapeLayer()
        
        alayer.backgroundColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 0.5).CGColor
        let    dicindex =  adic[index]
        let     pos = Int(dicindex!)
        let    posbtn = self.btns[pos!] as?  ItemButton
        alayer.frame = (posbtn?.bounds)!
        
        alayer.borderColor  = UIColor.redColor().CGColor
        alayer.borderWidth = 2.0
        
        posbtn?.layer.addSublayer(alayer)
        self.delegate?.transportresult(getresult())
        
    }
    //现在呢 希望点的时候干什么？  来一个定时器  让它循环调用这个函数
    
    func yaoyiyao(sender:ItemButton)  {
        
        
        if sender.titleLabel?.text == "抽奖" {
                sender.setTitle("停止", forState: .Normal)
            if gametime != nil {
                gametime.invalidate()
                gametime = nil
                gametime = NSTimer(timeInterval: 0.05, target: self, selector: #selector(updatedisplay), userInfo: nil, repeats: true)
                NSRunLoop.mainRunLoop().addTimer(gametime, forMode: NSDefaultRunLoopMode)
            }
            else{
                gametime = NSTimer(timeInterval: 0.05, target: self, selector: #selector(updatedisplay), userInfo: nil, repeats: true)
                NSRunLoop.mainRunLoop().addTimer(gametime, forMode: NSDefaultRunLoopMode)
            }
        }
        else{
             sender.setTitle("抽奖", forState: .Normal)
            if gametime != nil {
                gametime.invalidate()
                gametime = nil
            }
          
        }
       
        //这里从selectindex 处开始转  数值越大越慢
        //当点击这个抽奖的时候  怎么考虑呢  如先快后慢的方式
        
            
       
        
    }
    //  利用定时器的特性来刷新
    func updatedisplay(){
        selectindex = (selectindex + 1 ) % 8
        
        selectitem(selectindex)
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        let   allbtns = subviews
        for item in allbtns {
            
            let   aitem = item  as! ItemButton
            let   column = (item.tag - 1000 ) % 3
            let   row =  (item.tag - 1000 ) / 3
            
            
            if item.tag == 1004  {
                
                
                item.sd_layout().widthIs(itemquare*0.8).heightIs(itemquare*0.5).leftSpaceToView(self , ox + CGFloat.init(column)  * ( itemquare + xpading) + itemquare * 0.1).topSpaceToView(self, ox + CGFloat.init(row) * ( itemquare + xpading) + itemquare * 0.25)
                
            }
            else
            {
                item.sd_layout().widthIs(itemquare).heightIs(itemquare).leftSpaceToView(self , ox + CGFloat.init(column)  * ( itemquare + xpading)).topSpaceToView(self, ox + CGFloat.init(row) * ( itemquare + xpading))
                
                aitem.jifenlable.sd_layout().leftSpaceToView(aitem,50)
            }
        }
          selectitem(0)
    }
    func getresult() ->  String {
        
        let    dicindex =  adic[selectindex]
        let     pos = Int(dicindex!)
        return   "选中:\(selectindex)" + "奖励:\(self.result[pos!])"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
