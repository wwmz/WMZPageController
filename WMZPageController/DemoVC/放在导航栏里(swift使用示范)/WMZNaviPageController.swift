//
//  WMZNaviPageController.swift
//  WMZPageController
//
//  Created by wmz on 2020/8/20.
//  Copyright © 2020 wmz. All rights reserved.
//

import UIKit

class WMZNaviPageController: WMZPageController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let param:WMZPageParam = PageParam()
            .wTitleArrSet()(["第一页","第二页"])
            .wControllersSet()([TestVC(),TestVC()])
            .wMenuPositionSet()(.init(3))
            .wMenuAnimalSet()(.init(6))
            .wMenuCellPaddingSet()(20)
            .wMenuTitleWidthSet()(100)
            .wMenuWidthSet()(200)
            .wMenuIndicatorYSet()(5)
        self.param = param;
        
    }
    

}
