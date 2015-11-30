# ZSAdvertismentView-Swift
自动循环广告轮播器
let advertisment:ZSAdvertismentView = ZSAdvertismentView.init(frame: CGRectMake(0, 0, 100, 100))
        advertisment.height = 300;
        advertisment.imagesName = ["name1","name2","name3"]
        advertisment.touchBlock = {
            (selectIndex:NSInteger) -> Void in print(selectIndex)
        }
        self.view.addSubview(advertisment)
