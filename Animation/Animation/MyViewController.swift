//
//  MyViewController.swift
//  Animation
//
//  Created by ike on 2017/11/14.
//  Copyright © 2017年 ike. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var myGridView: MCGridView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    /***
     * 1、
     */
        self.myGridView.mcSetSections(Sections: 1).mcRegisterBundleNameCells(BundleNameCells: [["MyGridViewCell": "MyGridViewCell"]], ElementKind: MCElementKind.MCElementKindCell).mcRegisterBundleNameCells(BundleNameCells: [["MyHFView": "MyHFView"]], ElementKind: .MCElementKindHeader).mcSetScrollDirection(ScrollDirection: UICollectionViewScrollDirection.vertical).mcLayoutSections { (indexPath, style) in
            style.mcSetRows(Rows: 200).mcSetItmeSize(ItmeSize: CGSize(width:50,height:50), ElementKind: .MCElementKindCell).mcSetItmeBundleName(ItmeBundleName: "MyGridViewCell", ElementKind: .MCElementKindCell).mcSetCellMinimumInter(CellMinimumInter: 10).mcSetSectionsLineSpacing(SectionsLineSpacing: 10).mcSetHeaderBundleNameIdentifier(HeaderNameIdentifier: "MyHFView").mcSetHeaderSize(HeaderSize: CGSize(width:60,height:60))
        }
        self.myGridView.mcLayoutCell { (indexPath, cell) in
            cell.backgroundColor = UIColor.red
        }
        self.myGridView.mcReturnClickCell { (clas, indexPath, tag, data) in
            print(indexPath.row,clas)
        }
    /**
     * 2、
     */
        self.myGridView.mcSetSections(Sections: 1).mcRegisterBundleNameCells(BundleNameCells: [["MyGridViewCell": "MyGridViewCell"]], ElementKind: MCElementKind.MCElementKindCell).mcRegisterBundleNameCells(BundleNameCells: [["MyHFView": "MyHFView"]], ElementKind: .MCElementKindHeader).mcSetScrollDirection(ScrollDirection: UICollectionViewScrollDirection.vertical).mcLayoutSectionsCell(Sections: { (indexPath, style) in
            style.mcSetRows(Rows: 200).mcSetItmeSize(ItmeSize: CGSize(width:50,height:50), ElementKind: .MCElementKindCell).mcSetItmeBundleName(ItmeBundleName: "MyGridViewCell", ElementKind: .MCElementKindCell).mcSetCellMinimumInter(CellMinimumInter: 10).mcSetSectionsLineSpacing(SectionsLineSpacing: 10).mcSetHeaderBundleNameIdentifier(HeaderNameIdentifier: "MyHFView").mcSetHeaderSize(HeaderSize: CGSize(width:60,height:60))
        }) { (indexPath, cell) in
            cell.backgroundColor = UIColor.red
        }
        self.myGridView.mcReturnClickCell { (clas, indexPath, tag, data) in
            print(indexPath.row,clas)
        }
    /**
     * 3、
     */
        self.myGridView.mcSetSections(Sections: 1).mcRegisterBundleNameCells(BundleNameCells: [["MyGridViewCell": "MyGridViewCell"]], ElementKind: MCElementKind.MCElementKindCell).mcRegisterBundleNameCells(BundleNameCells: [["MyHFView": "MyHFView"]], ElementKind: .MCElementKindHeader).mcSetScrollDirection(ScrollDirection: UICollectionViewScrollDirection.vertical).mcLayoutSectionsCellClick(Sections: { (indexPath, style) in
            style.mcSetRows(Rows: 200).mcSetItmeSize(ItmeSize: CGSize(width:50,height:50), ElementKind: .MCElementKindCell).mcSetItmeBundleName(ItmeBundleName: "MyGridViewCell", ElementKind: .MCElementKindCell).mcSetCellMinimumInter(CellMinimumInter: 10).mcSetSectionsLineSpacing(SectionsLineSpacing: 10).mcSetHeaderBundleNameIdentifier(HeaderNameIdentifier: "MyHFView").mcSetHeaderSize(HeaderSize: CGSize(width:60,height:60))
        }, CellBlock: { (indexPath, cell) in
            cell.backgroundColor = UIColor.yellow
        }) { (clas, indexPath, tag, data ) in
            print(indexPath)
        }
        self.myGridView.mcReturnClickHFView { (cla, indexPath, tag, data) in
            print(cla,indexPath,tag,data)
        }
        /**
         *4、
         */
        self.myGridView.mcSetSections(Sections: 1).mcRegisterBundleNameCells(BundleNameCells: [["MyGridViewCell": "MyGridViewCell"]], ElementKind: .MCElementKindCell).mcRegisterBundleNameCells(BundleNameCells: [["MyHFView": "MyHFView"]], ElementKind: .MCElementKindHeader).mcSetScrollDirection(ScrollDirection: UICollectionViewScrollDirection.vertical).mcLayoutSectionsCellClick(Sections: { (indexPath, style) in
            style.mcSetRows(Rows: 200).mcSetItmeSize(ItmeSize: CGSize(width:50,height:50), ElementKind: .MCElementKindCell).mcSetItmeBundleName(ItmeBundleName: "MyGridViewCell", ElementKind: .MCElementKindCell).mcSetCellMinimumInter(CellMinimumInter: 10).mcSetSectionsLineSpacing(SectionsLineSpacing: 10).mcSetHeaderBundleNameIdentifier(HeaderNameIdentifier: "MyHFView").mcSetHeaderSize(HeaderSize: CGSize(width:60,height:60))
        }, CellBlock: { (indexPath, cell) in
            cell.backgroundColor = UIColor.yellow
        }, ClickCell: { (clas, indexPath, tag, data) in
            print(indexPath)
        }, HFViewBlcok: { (indexPath, hfView) in
            hfView.backgroundColor = UIColor.red
        }) { (chas, indexPath, tag, data) in
             print("hfView",indexPath)
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
