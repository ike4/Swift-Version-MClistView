//
//  ViewController.swift
//  Animation
//
//  Created by ike on 2017/11/2.
//  Copyright © 2017年 ike. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var myTableView: MCTableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout = Bundle.main.loadNibNamed("LayoutView", owner: nil, options: nil)?.last as?LayoutView
        layout?.frame = CGRect(x: 0,y: 0,width: self.view.bounds.size.width,height: self.view.bounds.size.height)
        self.view .addSubview(layout!)

        layout?.mcReturnData(blockData: { (str) in
            print(str)
        })

        layout?.block!("123231232")

        layout?.mcReturnData(blockData: { (str) in
            print("11222---->",str)
        }, setBlock: { (data) in

        })
//        let data = MCTableViewDataSource.init()
        let data = MCTableView.init()
//        data.mcSetString(String: "123456")
        data.mcSetSections(Sections: 1).mcLayoutSectionsCell(Section: { (indexPath: NSIndexPath, layout: MCTableViewDataSource ) in
            layout.mcSetRows(Rows: 5)
        }) { (indxPath: NSIndexPath, Cell: MCTableViewCell) in
            
        }
        
//        let label = UILabel()
//        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
//        label.frame = rect
//        label.backgroundColor = UIColor.red
//        self.view.addSubview(label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

