//
//  LayoutView.swift
//  Animation
//
//  Created by ike on 2017/11/2.
//  Copyright © 2017年 ike. All rights reserved.
//

import UIKit
typealias MCReturn = (Any)->()
class LayoutView: UIView {
    var block: MCReturn?
    override func awakeFromNib() {
        super .awakeFromNib()
        
    }
    func mcReturnData(blockData: @escaping MCReturn){
        self.block = blockData
    }
    func mcReturnData(blockData: @escaping MCReturn,setBlock: @escaping MCReturn){
        self.block = blockData
    }
    @IBAction func btnClick(_ sender: UIButton) {
        if (self.block != nil) {
            self.block?("12")
        }
    }
    
}
