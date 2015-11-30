//
//  ZSAdvertismentView.swift
//  ZSAdvertismentScroll
//
//  Created by 张森 on 15/11/30.
//  Copyright © 2015年 张森. All rights reserved.
//

import UIKit
typealias block = (selectIndex:NSInteger) -> Void

class ZSAdvertismentView: UIView,UIScrollViewDelegate {
    
    private var windth : CGFloat?
    
    weak var scrollView : UIScrollView?
    weak var pageControl : UIPageControl?
    
    var timer : NSTimer?
    var _imagesName : NSArray?
    var touchBlock : block?
    var height : CGFloat? = 200
    
    var imagesName: NSArray?{
        get {
            return _imagesName
        }
        set {
            _imagesName = newValue
            var array:NSMutableArray?
            array = NSMutableArray.init(capacity: 0)
            array!.addObject(newValue!.lastObject!)
            for obj:AnyObject in newValue!{
                array?.addObject(obj)
            }
            array!.addObject(newValue![0])
            _imagesName = array
            self.createFrame(newValue!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.blackColor()
        windth = UIScreen.mainScreen().bounds.size.width
        self.startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageTouch(button:UIButton){
        if touchBlock != nil{
            touchBlock!(selectIndex:button.tag - 1)
        }
    }
    
    func createUI(){
        let scrollView:UIScrollView = UIScrollView.init()
        self.scrollView = scrollView
        self.addSubview(scrollView)

        scrollView.delegate=self
        scrollView.pagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        
        let pageControl:UIPageControl = UIPageControl.init();
        self.addSubview(pageControl)
        self.pageControl = pageControl
        
        pageControl.currentPage=0
        pageControl.pageIndicatorTintColor=UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor(red:90/255.0, green: 200/255.0, blue: 255/255.0, alpha: 1.0)
        
        scrollView.frame = self.bounds;
        
        let imageH:CGFloat = self.scrollView!.frame.size.height;
        
        for var i:Int = 0;i < _imagesName!.count ; i++ {
            let imageButton:UIButton = UIButton.init(type: UIButtonType.Custom)
            imageButton.setBackgroundImage(UIImage.init(named:_imagesName![i] as! String), forState: UIControlState.Normal)
            let imageX:CGFloat = (CGFloat)(i) * windth!;
            imageButton.frame = CGRectMake(imageX, 0, windth!, imageH);
            imageButton.tag=i + 1
            imageButton.addTarget(self, action: "imageTouch:", forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollView?.addSubview(imageButton)
        }
    }
    
    func createFrame(newValue:NSArray?){
        self.frame = CGRectMake(0, 0, windth!, height!)
        self.createUI()
        self.scrollView!.contentSize=CGSizeMake((CGFloat)(_imagesName!.count) * windth!, 0);
        self.scrollView!.contentOffset = CGPointMake(windth!, 0);
        
        self.pageControl!.numberOfPages = newValue!.count;
        let pageW:CGFloat = (CGFloat)(self.pageControl!.numberOfPages * 20);
        let pageX:CGFloat = 0;
        let pageY:CGFloat = self.frame.size.height - 20;
        self.pageControl!.frame = CGRectMake(pageX, pageY, pageW, 20);
    }
    
    func startTimer(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target:self,selector:"autoScroll",userInfo:nil,repeats:true)
        // 把timer对象事件交给主要线程处理，不会出现UI阻塞
        NSRunLoop.currentRunLoop().addTimer(self.timer!, forMode:NSRunLoopCommonModes);
    }
    
    func autoScroll(){
        let page:Int = (Int)((self.scrollView?.contentOffset.x)! / self.frame.size.width)
        let offSetX:CGFloat = (CGFloat)(page) * (self.scrollView?.frame.size.width)! + (self.scrollView?.frame.size.width)!
        self.scrollView?.setContentOffset(CGPointMake(offSetX,0), animated: true)
    }
    
    // 代理方法
    func scrollViewDidScroll(scrollView: UIScrollView){
        let Width:CGFloat=self.frame.size.width;
        if (scrollView.contentOffset.x <= 0) {
            self.scrollView!.setContentOffset(CGPointMake(Width * (CGFloat)(self.imagesName!.count-2), 0),animated:false)
        }else if (scrollView.contentOffset.x >= Width*(CGFloat)((self.imagesName?.count)!-1)) {
            self.scrollView!.setContentOffset(CGPointMake(self.frame.size.width, 0),animated:false)
        }
        self.pageControl!.currentPage = (Int)(scrollView.contentOffset.x / self.frame.size.width-1);
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        self.timer!.invalidate()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, decelerate: Bool){
        self.startTimer()
    }
}
