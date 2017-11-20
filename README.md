# Swift-Version-MClistView
Swift版本MClistView
快速开发tableView
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
        }self.myGridView.mcSetSections(Sections: 1).mcRegisterBundleNameCells(BundleNameCells: [["MyGridViewCell": "MyGridViewCell"]], ElementKind: MCElementKind.MCElementKindCell).mcRegisterBundleNameCells(BundleNameCells: [["MyHFView": "MyHFView"]], ElementKind: .MCElementKindHeader).mcSetScrollDirection(ScrollDirection: UICollectionViewScrollDirection.vertical).mcLayoutSections { (indexPath, style) in
            style.mcSetRows(Rows: 200).mcSetItmeSize(ItmeSize: CGSize(width:50,height:50), ElementKind: .MCElementKindCell).mcSetItmeBundleName(ItmeBundleName: "MyGridViewCell", ElementKind: .MCElementKindCell).mcSetCellMinimumInter(CellMinimumInter: 10).mcSetSectionsLineSpacing(SectionsLineSpacing: 10).mcSetHeaderBundleNameIdentifier(HeaderNameIdentifier: "MyHFView").mcSetHeaderSize(HeaderSize: CGSize(width:60,height:60))
        }
        self.myGridView.mcLayoutCell { (indexPath, cell) in
            cell.backgroundColor = UIColor.red
        }
        self.myGridView.mcReturnClickCell { (clas, indexPath, tag, data) in
            print(indexPath.row,clas)
        }
    
