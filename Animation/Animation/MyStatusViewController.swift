//
//  MyStatusViewController.swift
//  Animation
//
//  Created by ike on 2017/11/5.
//  Copyright © 2017年 ike. All rights reserved.
//

import UIKit

class MyStatusViewController: UIViewController {
    var page:NSInteger = 100
    @IBOutlet weak var myListView: MCTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /**
         1、
         */
        self.myListView.mcSetSections(Sections: 1).mcLayoutSectionsCell(Section: { (indexPath, layout) in
            layout.mcSetRows(Rows: self.page).mcSetItmeBundleName(ItmeBundleName: "tableTFView", MCElementKind: .MCElementKindCell).mcSetItmeHeight(ItmeHeight: 50, ElementKind: .MCElementKindHeader).mcSetItmeHeight(ItmeHeight: 50, ElementKind: .MCElementKindFooter).mcSetItmeBundleName(ItmeBundleName: "tableTFView", MCElementKind: .MCElementKindHeader).mcSetItmeBundleName(ItmeBundleName: "tableTFView", MCElementKind: .MCElementKindFooter)
        }) { (indexPath, itme) in
            let cell:TableViewCell = itme as! TableViewCell
            cell.label.text = String(indexPath.row)
        }
        self.myListView.mcLayoutSectionHFView { (indexPath, HFView) in
            print(indexPath.row)
        }
        self.myListView.mcReturnClickCell { (tableView, indexPath, tag, clas) in
            if clas as? NSNull != NSNull() {
                if clas is NSDictionary{
                   print(clas)
                }else if clas is NSArray{
                    print("1111",clas)
                }else if clas is UIButton{
                    print(clas)
                }

            }
        }
        /**
         2、
         */
        self.myListView.mcSetSections(Sections: 1) .mcLayoutHFViewClickItmeIndexPath(Section: { (indexPath, layout) in
            layout.mcSetRows(Rows: self.page).mcSetItmeBundleName(ItmeBundleName: "tableTFView", MCElementKind: .MCElementKindCell).mcSetItmeHeight(ItmeHeight: 50, ElementKind: .MCElementKindHeader).mcSetItmeHeight(ItmeHeight: 50, ElementKind: .MCElementKindFooter).mcSetItmeBundleName(ItmeBundleName: "tableTFView", MCElementKind: .MCElementKindHeader).mcSetItmeBundleName(ItmeBundleName: "tableTFView", MCElementKind: .MCElementKindFooter)
        }, Cell: { (indexPath, itme) in
            let cell:TableViewCell = itme as! TableViewCell
//            cell.label.text = String(indexPath.row)
            cell.mcSetBottomHeight(BottomHeight: 10).mcSetHeight(Height: 100)
            cell.backgroundColor = UIColor.red
        }, Click: { (tableView, indexPath, tag, data) in
            print("回执结果",indexPath.row,tag,data)
        }) { (indexPath, HFView) in
            print(indexPath.row)
            HFView.backgroundColor = UIColor.yellow
        }
        self.myListView.mcReturnClickHFView { (tableView, indexPath, tag, data) in
            print(indexPath.row,indexPath.section)
        }
        self.myListView.mcSetEditingStyleReturnCell(EditingStyle: { (indexPath, style) in
            style.mcEditingStyle(EditingStyle: UITableViewCellEditingStyle.delete).mcEditingName(EditingTitle: "删除")
        }) { (indexPath, nil) in
            self.page -= 10
            print(indexPath)
            self.myListView.reloadData()
        }
        self.myListView.mcReturnItmeTFViewBeginEditing { (indexPath, tag) in
            print(indexPath.section,indexPath.row,tag)
        }
        self.myListView.mcReturnItmeTFViewShouldChange { (indexPath, Class, range, string, style) in
            print(indexPath.row,range,string,style)
            style.mcSetIsOk(IsOk: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
