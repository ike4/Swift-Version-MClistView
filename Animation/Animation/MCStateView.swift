//
//  MCStateView.swift
//  Animation
//
//  Created by ike on 2017/11/3.
//  Copyright © 2017年 ike. All rights reserved.
//

import UIKit

typealias MCClcikClassBlock = (_ indexPath: NSIndexPath,_ tag: NSInteger)->()
typealias MCTFViewShouldChange = (_ indexPath: NSIndexPath,_ TFView: Any,_ range: NSRange,_ string: String,_ shouldChangeStyle: MCellShouldChangeStyle)->()
typealias MCellEditingLayoutStyle = (_ indexPath: NSIndexPath,_ style: MCellEditingStyle)->()
typealias MCReturnItme = (_ tag: NSInteger,_ data: Any)->()
typealias MCTableViewLayoutSection = (_ indexPath: NSIndexPath,_ mcLayout: MCTableViewDataSource)->()
typealias MCTableViewLayoutCell = (_ indexPath: NSIndexPath,_ Cell: MCTableViewCell)->()
typealias MCReturnClick = (_ ControlsView: AnyObject,_ indexPath: NSIndexPath,_ tag: NSInteger,_ data: Any)->()
typealias MCReturnSlidingScroll = (_ scroll: CGFloat)->()
enum MCElementKind : NSInteger{
    case MCElementKindCell
    case MCElementKindHeader
    case MCElementKindFooter
}
//MARK:**************************************************************************
//MARK:************************************* MCTabelView ************************
//MARK:**************************************************************************
class MCTableView: UITableView,UITableViewDelegate, UITableViewDataSource{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
//MARK:----------- layout MCTableView the callback
    //MARK: MC - layout Sections number
    /// MC - 设置多少个区
    ///
    /// - Parameter Sections: <#Sections description#>
    /// - Returns: <#return value description#>
    func mcSetSections(Sections: NSInteger) -> MCTableView {
        self.wDataSource.wNumberSections = Sections
        return self
    }
    //MARK: MC - layout section
    /// MC - 布局单个区
    ///mcSetRows、mcSetItmeName、mcSetHeaderHeight、mcSetFooterHeight、mcSetHeaderBundleName、mcSetFooterBundleName
    /// - Parameter block: mcSetRows、mcSetItmeName、mcSetHeaderHeight、mcSetFooterHeight、mcSetHeaderBundleName、mcSetFooterBundleName
    func mcLayoutSections(block: @escaping MCTableViewLayoutSection){
        self.wLayoutSection = block
    }
    //MARK: MC - Callback section HFView
    /// MC - 处理 区头(indexPath.row = -1)、区尾(indexPath.row = -2)
    ///
    /// - Parameter HFView: 单个模块处理
    func mcLayoutSectionHFView(HFView: @escaping MCTableViewLayoutCell)->(){
        self.wHFView = HFView
    }
    //MARK: MC - Callback rows cell
    /// MC - 返回 cell
    ///
    /// - Parameter block: 单个模块处理
    func mcLayoutCell(block: @escaping MCTableViewLayoutCell)->(){
        self.wLayoutCell = block
    }
    //MARK: MC - layout and callback section rows cell
    /// MC - 设置区展示模块 + 返回Cell
    ///
    /// - Parameters:
    ///   - Section: cell模块展示处理
    ///   - Cell: 单个模块处理
    func mcLayoutSectionsCell(Section: @escaping MCTableViewLayoutSection,Cell: @escaping MCTableViewLayoutCell) -> () {
        self.wLayoutSection = Section
        self.wLayoutCell = Cell
    }
    //MARK: MC - Sliding view callback
    /// MC - 监听滑动值
    ///
    /// - Parameter Scroll: <#Scroll description#>
    func mcReturnSlidingCallback(Scroll: @escaping MCReturnSlidingScroll) -> () {
        self.wScroll = Scroll
    }
    //MARK: MC - layout section rows cell click
    /// MC - 设置区展示模块 + 实现 + 点击事件回调
    ///
    /// - Parameters:
    ///   - Section: cell模块展示处理
    ///   - Cell: 单个模块处理
    ///   - Click: 点击事件回调
    func mcLayoutClickItmeIndexPath(Section: @escaping MCTableViewLayoutSection,Cell: @escaping MCTableViewLayoutCell,Click: @escaping MCReturnClick) -> () {
        self.wLayoutSection = Section
        self.wLayoutCell = Cell
        self.wClickCell = Click
    }
    //MARK: MC - Set sliding style click callback
    /// MC - 滑动风格和点击回调
    ///
    /// - Parameters:
    ///   - EditingStyle: Set Style
    ///   - BlockCell: Click callback
    func mcSetEditingStyleReturnCell(EditingStyle: @escaping MCellEditingLayoutStyle,BlockCell: @escaping MCClcikClassBlock) -> () {
        self.wLayoutEditingStyle = EditingStyle
        self.wClickEditingCell = BlockCell
    }
    //MARK: MC - HFView Click header(indexPath.row:-1) footer(indexPath.row:-2)
    /// MC - 区头、区尾点击事件  区头indexPath.row:-1 区尾indexPath.row:-2
    ///
    /// - Parameter ClickHFView: Click callback
    func mcReturnClickHFView(ClickHFView: @escaping MCReturnClick) -> () {
        self.wClickHFView = ClickHFView
    }
    //MARK: MC - Cell Click
    /// MC - Cell 点击事件
    ///
    /// - Parameter ClickCell: 点击事件回调
    func mcReturnClickCell(ClickCell: @escaping MCReturnClick) -> () {
        self.wClickCell = ClickCell
    }
    //MARK: MC - layout section rows cell click and callback HFView
    /// MC - 展示模块 + 实现 + rows点击事件回调 + 区头、区尾实现
    ///
    /// - Parameters:
    ///   - Section: cell模块展示处理
    ///   - Cell: 单个模块处理
    ///   - Click: 点击事件回调
    ///   - HFView: 区头、区尾处理
    func mcLayoutHFViewClickItmeIndexPath(Section: @escaping MCTableViewLayoutSection,Cell: @escaping MCTableViewLayoutCell,Click: @escaping MCReturnClick,HFView: @escaping MCTableViewLayoutCell) -> () {
        self.wLayoutSection = Section
        self.wLayoutCell = Cell
        self.wClickCell = Click
        self.wHFView = HFView
    }
    //MARK: MC - TFView Begin
    /// MC - TFView 开始编辑调用 header: -1 footer：-2
    ///
    /// - Parameter Begin: <#Begin description#>
    func mcReturnItmeTFViewBeginEditing(Begin: @escaping MCClcikClassBlock) -> () {
        self.wBegin = Begin
    }
    //MARK: MC - TFView ShouldChange
    /// MC - TFView 输入状态值自行处理 section: -1 footer：-2
    ///
    /// - Parameter block: <#block description#>
    func mcReturnItmeTFViewShouldChange(Block: @escaping MCTFViewShouldChange) -> () {
        self.wShouldChange = Block
    }
    //MARK: MC - TFView Begin and ShouldChange
    /// MC - TFView 开始编辑调用和输入状态值自行处理 header: -1 footer：-2
    ///
    /// - Parameters:
    ///   - Begin: 开始编辑调用
    ///   - ShouldChange: 输入状态值自行处理
    func mcReturnItmeTFViewBeginShouldChangeEditing(Begin: @escaping MCClcikClassBlock,ShouldChange: @escaping MCTFViewShouldChange) -> () {
        self.wBegin = Begin
        self.wShouldChange = ShouldChange
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.wScroll != nil {
            self.wScroll?(scrollView.contentOffset.y)
        }
    }
    override func numberOfRows(inSection section: Int) -> Int {
        return self.wDataSource.wNumberSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         self.SetLayoutBlocK(indexPath: IndexPath(row:0,section:section) as NSIndexPath, cell: NSNull())
        return self.wDataSource.wRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idCell :String = "idCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? MCTableViewCell
        if cell == nil {
            self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: NSNull())
            cell = Bundle.main.loadNibNamed(self.wDataSource.wItmeName, owner: nil, options: nil)?.first as? MCTableViewCell
        }else{
            while cell?.contentView.subviews.last != nil{
                cell?.contentView.subviews.last?.removeFromSuperview()
            }
        }
        if (self.wLayoutCell != nil) {
            self.wLayoutCell?(indexPath as NSIndexPath,cell!)
        }
        self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: cell!)
        cell?.mcReturnCellData(block: { (tag, data) in
            if self.wClickCell != nil{
                self.wClickCell?(self,indexPath as NSIndexPath,tag,data)
            }
        })
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.wDataSource.wItmeHeight != -1 {
            return CGFloat(self.wDataSource.wItmeHeight)
        }else{
            let cell = self.tableView(tableView, cellForRowAt: indexPath) as? MCTableViewCell
            return (cell?.bounds.size.height)!
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.SetLayoutBlocK(indexPath: IndexPath(row:-1,section:section) as NSIndexPath, cell: NSNull())
        return CGFloat(self.wDataSource.wHeaderHeight)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.SetLayoutBlocK(indexPath: IndexPath(row:-2,section:section) as NSIndexPath, cell: NSNull())
        return CGFloat(self.wDataSource.wFooterHeight)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let indexPath = IndexPath(row:-1,section:section)
        self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: NSNull())
        if self.wDataSource.wHeaderName.count != 0 {
            let headerView = Bundle.main.loadNibNamed(self.wDataSource.wHeaderName, owner: nil, options: nil)?.first as? MCTableViewCell
            headerView?.backgroundColor = UIColor.white
            headerView?.tag = section
            if (self.wHFView != nil) {
                self.wHFView?(indexPath as NSIndexPath,headerView!)
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHeaderClick(sender:)))
            headerView?.isUserInteractionEnabled = true
            if headerView?.gestureRecognizers == nil{
                headerView?.addGestureRecognizer(tap)
            }
            self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: headerView!)
            return headerView
        }else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let indexPath = IndexPath(row:-2,section:section)
        self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: NSNull())
        if self.wDataSource.wHeaderName.count != 0 {
            let headerView = Bundle.main.loadNibNamed(self.wDataSource.wFooterName, owner: nil, options: nil)?.first as? MCTableViewCell
            headerView?.backgroundColor = UIColor.white
            if (self.wHFView != nil) {
                self.wHFView?(indexPath as NSIndexPath,headerView!)
            }
            headerView?.tag = section
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapFooterClick(sender:)))
            headerView?.isUserInteractionEnabled = true
            if headerView?.gestureRecognizers == nil{
                headerView?.addGestureRecognizer(tap)
            }
            self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: headerView!)
            return headerView
        }else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if self.wLayoutEditingStyle != nil{
            self.wLayoutEditingStyle?(indexPath as NSIndexPath,self.wEditingStyle)
        }
        return self.wEditingStyle.wEditingStyle!
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if self.wLayoutEditingStyle != nil{
            self.wLayoutEditingStyle?(indexPath as NSIndexPath,self.wEditingStyle)
        }
        if self.wClickEditingCell != nil {
            self.wClickEditingCell?(indexPath as NSIndexPath, 0)
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        if self.wLayoutEditingStyle != nil{
            self.wLayoutEditingStyle?(indexPath as NSIndexPath,self.wEditingStyle)
        }
        return self.wEditingStyle.wEditingTitle
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.wLayoutSection != nil {
            self.wLayoutSection?(IndexPath(row: -1,section: section) as NSIndexPath,self.wDataSource)
        }
        return self.wDataSource.wHeaderTitle
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self.wLayoutSection != nil {
            self.wLayoutSection?(IndexPath(row: -1,section: section) as NSIndexPath,self.wDataSource)
        }
        return self.wDataSource.wFooterTitle
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        self.SetLayoutBlocK(indexPath: indexPath! as NSIndexPath, cell: NSNull())
        
    }
    //MARK: MC - ******* Commet Set layout BlocK
    func SetLayoutBlocK(indexPath: NSIndexPath,cell : Any) -> (){
        if cell as? NSNull != NSNull() {
            let cell = cell as! MCTableViewCell
            cell.mcReturnTFViewBeginEditing(block: { (nil, tag) in
                if self.wBegin != nil{
                    self.wBegin?(indexPath as NSIndexPath,tag)
                }
            })
            if (self.wShouldChange != nil) {
                cell.mcReturnTFViewShouldChange(block: { (nil, wClass, range, string, style) in
                    self.wShouldChange?(indexPath as NSIndexPath, wClass, range, string, style)
                })
            }
        }else{
            if (self.wLayoutSection != nil) {
                self.wLayoutSection?(indexPath as NSIndexPath, self.wDataSource)
            }
            if self.wLayoutEditingStyle != nil{
                self.wLayoutEditingStyle?(indexPath,self.wEditingStyle)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.wClickCell != nil {
            self.wClickCell?(tableView,indexPath as NSIndexPath,0,NSNull())
        }
    }
    @objc func tapHeaderClick(sender: UITapGestureRecognizer){
        if self.wClickHFView != nil {
            self.wClickHFView?(self,IndexPath(row:-1,section:(sender.view?.tag)!) as NSIndexPath,0,NSNull())
        }
    }
    @objc func tapFooterClick(sender: UITapGestureRecognizer){
        if self.wClickHFView != nil {
            self.wClickHFView?(self,IndexPath(row:-2,section:(sender.view?.tag)!) as NSIndexPath,0,NSNull())
        }
    }
    var wDataSource = MCTableViewDataSource()//控件赋值
    var wLayoutSection: MCTableViewLayoutSection?//区的处理
    var wHFView: MCTableViewLayoutCell?//返回区头、尾处理
    var wLayoutCell: MCTableViewLayoutCell?
    var wClickCell: MCReturnClick?
    var wClickHFView: MCReturnClick?
    var wBegin: MCClcikClassBlock?
    var wShouldChange: MCTFViewShouldChange?
    var wClickEditingCell: MCClcikClassBlock?
    var wLayoutEditingStyle: MCellEditingLayoutStyle?
    var wEditingStyle = MCellEditingStyle()
    var wScroll : MCReturnSlidingScroll?
    
    
}
//MARK:************************************* MCellTFViewShouldChangeStyle
class MCellShouldChangeStyle: NSObject {
    //MARK: MC - Set isOK
    ///  MC - Set isOK
    ///
    /// - Parameter mcIsOk: <#mcIsOk description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetIsOk(IsOk: Bool) -> MCellShouldChangeStyle {
        self.wIsOk = IsOk
        return self
    }
    var wIsOk = Bool()
}
//MARK:************************************* MCTableViewDataSource
class MCTableViewDataSource: NSObject {
    //MARK: MC - Set section in cell rows number
    /// MC - 设置区中的cell的数量
    ///
    /// - Parameter mcRows: <#mcRows description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetRows(Rows: NSInteger) -> MCTableViewDataSource {
        self.wRows = Rows
        return self
    }
    //MARK: MC - Set Itme Bundle name xib
    /// MC - 设置Itme Bundle name xib
    ///
    /// - Parameter mcItmeName: <#mcItmeName description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetItmeBundleName(ItmeBundleName: String,MCElementKind: MCElementKind) -> MCTableViewDataSource {
        if MCElementKind == .MCElementKindCell{
            self.wItmeName = ItmeBundleName
        }else if MCElementKind == .MCElementKindHeader{
            self.wHeaderName = ItmeBundleName
        }else if MCElementKind == .MCElementKindFooter{
            self.wFooterName = ItmeBundleName
        }
        return self
    }
    //MARK: MC - Set header in section default title
    /// MC - 设置区头默认的title
    ///
    /// - Parameter mcHeaderTitle: <#mcHeaderTitle description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetHeaderTitle(HeaderTitle: String) -> MCTableViewDataSource {
        self.wHeaderTitle = HeaderTitle
        return self
    }
    //MARK: MC - Set footer in section default title
    ///  MC - 设置区尾默认的title
    ///
    /// - Parameter mcFooterTitle: <#mcFooterTitle description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetFooterTitle(FooterTitle: String) -> MCTableViewDataSource {
        self.wFooterTitle = FooterTitle
        return self
    }
    //MARK: MC - Set Itme height
    ///  MC - 设置Itme固定的高度
    ///
    /// - Parameter mcHeaderHeight: <#mcHeaderHeight description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetItmeHeight(ItmeHeight: Float,ElementKind: MCElementKind) -> MCTableViewDataSource {
        if ElementKind == .MCElementKindCell{
            self.wItmeHeight = ItmeHeight
        }else if ElementKind == .MCElementKindHeader{
            self.wHeaderHeight = ItmeHeight
        }else if ElementKind == .MCElementKindFooter{
            self.wFooterHeight = ItmeHeight
        }
        return self
    }
    
    var wNumberSections = NSInteger()
    var wRows = NSInteger()
    var wItmeName = String()
    var wHeaderHeight = Float()
    var wFooterHeight = Float()
    var wItmeHeight: Float = -1
    var wHeaderName = String()
    var wFooterName = String()
    var wHeaderTitle = String()
    var wFooterTitle = String()
}
//MARK:************************************* MCTableViewCell
class MCTableViewCell: ViewFrameCell, UITextFieldDelegate, UITextViewDelegate,UISearchBarDelegate{
    @IBOutlet weak var mcTFView: UITextField!
    @IBOutlet weak var mcTxtView: UITextView!
    @IBOutlet weak var mcSearchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if (mcTFView != nil){
            mcTFView.delegate = self
        }
        if (mcTxtView != nil) {
            mcTxtView.delegate = self
        }
        if (mcSearchBar != nil) {
           mcSearchBar.delegate = self
        }
    }
    //MARK: MC - Set bottom height
    ///  MC - 设置底部的高
    ///
    /// - Parameter mcBottomHeight: <#mcBottomHeight description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetBottomHeight(BottomHeight: Float) -> MCTableViewCell {
        self.bottomHeight = CGFloat(BottomHeight)
        return self
    }
    //MARK: MC - Set height
    /// MC - 设置高
    ///
    /// - Parameter Height: <#Height description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetHeight(Height: Float) -> MCTableViewCell {
        self.frame.size.height = CGFloat(Height);
        return self
    }
    //MARK: MC - Set the click event callback data block
    /// MC - 数据传递(按钮点击事件)
    ///
    /// - Parameter block: <#block description#>
    func mcReturnCellData(block: @escaping MCReturnItme) -> () {
        self.wClick = block
    }
    //MARK: MC - TFView start the editor callback
    /// MC - TFView 开始编辑调用
    ///
    /// - Parameter block: <#block description#>
    func mcReturnTFViewBeginEditing(block: @escaping MCClcikClassBlock) -> () {
        self.wBegin = block
    }
    //MARK: MC - TFView edits state value deal callback
    /// MC - TFView 编辑状态值回调
    ///
    /// - Parameter block: <#block description#>
    func mcReturnTFViewShouldChange(block: @escaping MCTFViewShouldChange) -> () {
        if !(self.shouldChangeStyle != nil) {
            self.shouldChangeStyle = MCellShouldChangeStyle.init()
        }
        self.wShouldChange = block;
    }
//MARK:------------------------------------- MCTableViewCellStyle
    //MARK: MC - Click on the style
    /// MC - 点击风格
    ///
    /// - Parameter SelectionStyle: <#SelectionStyle description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSelectionStyle(SelectionStyle: UITableViewCellSelectionStyle) -> MCTableViewCell {
        self.selectionStyle = UITableViewCellSelectionStyle(rawValue: SelectionStyle.rawValue)!;
        return self
    }
    //MARK: MC - Show on the style
    /// MC - 展示风格 UITableViewCellAccessoryType
    ///
    /// - Parameter AccessoryType: <#AccessoryType description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcAccessoryType(AccessoryType: UITableViewCellAccessoryType) -> MCTableViewCell {
        self.accessoryType = AccessoryType;
        return self
    }
    @IBAction func buttonClick(_ sender: UIButton){
        if (self.wClick != nil) {
            self.wClick?(sender.tag,sender)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),textField.tag)
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(textField.tag,textField.text as Any)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textField, range, string,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),textView.tag)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textView, range, text,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(textView.tag,textView.text as Any)
        }
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),searchBar.tag)
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textView, range, text,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.endEditing(true)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(searchBar.tag,searchBar.text as Any)
        }
        return true
    }
    var wBegin: MCClcikClassBlock?
    var wShouldChange: MCTFViewShouldChange?
    var wClick: MCReturnItme?
    var shouldChangeStyle: MCellShouldChangeStyle!
}
//MARK:************************************* MCellEditingStyle
class MCellEditingStyle: NSObject {
    //MARK: MC - Set sliding style
    /// MC - 设置滑动风格
    ///
    /// - Parameter EditingStyle: <#EditingStyle description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcEditingStyle(EditingStyle: UITableViewCellEditingStyle) -> MCellEditingStyle {
        self.wEditingStyle = EditingStyle
        return self
    }
    //MAKR: MC - Set sliding title
    /// MC - 滑动显示 title
    ///
    /// - Parameter EditingTitle: <#EditingTitle description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcEditingName(EditingTitle: String) -> MCellEditingStyle {
        self.wEditingTitle = EditingTitle
        return self
    }
    var wEditingStyle = UITableViewCellEditingStyle.init(rawValue: 0)
    var wEditingTitle = String()
}
typealias MCGridViewLayoutSection = (_ indexPath: NSIndexPath,_ mcLayout: MCGridDataSource)->()
typealias MCGridViewLayoutCell = (_ indexPath: NSIndexPath,_ Cell: MCGridViewCell)->()
typealias MCGridViewLayoutHFCell = (_ indexPath: NSIndexPath,_ Cell: MCGridHFView)->()
//MARK:**************************************************************************
//MARK:************************************* MCGridView *************************
//MARK:**************************************************************************
class MCGridView: UICollectionView,UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //MARK:******************** 使用前阅读 **********************
    /**
         1、xib 新建要集成MCLayoutCell header、footerView集成MCHFLayoutView(UICollectionReusableView)
         2、使用框架前 先看(必填的使用)
         3、然后使用步骤的(1、2)这两点
         4、一些方法代理不全可以单独集成代理方法来实现
         注:崩溃原因{1、没有注册Itme 2、没有注册headerView、footerView(使用则注册)}
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
    
    //MARK: MC - layout Sections number
    /// MC - 设置多少个区
    ///
    /// - Parameter Sections: <#Sections description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetSections(Sections: NSInteger) -> MCGridView {
        self.wDataSoure.wSections = Sections
        return self
    }
    //MARK: MC - Register BundleName
    /// MC - 注册Cell BundleNameCells:[[BundleName:Identifier]] ElementKind:取枚举
    ///
    /// - Parameters:
    ///   - BundleNameCells: <#BundleNameCells description#>
    ///   - ElementKind: 注册Cell说明
    /// - Returns: <#return value description#>
    @discardableResult
    func mcRegisterBundleNameCells(BundleNameCells: Array<NSDictionary>,ElementKind: MCElementKind) -> MCGridView {
        for data in BundleNameCells {
            if data.isKind(of: NSDictionary.self){
                if ElementKind == .MCElementKindCell{
                    self.register(UINib.init(nibName: data.allKeys.first as! String, bundle: Bundle.main), forCellWithReuseIdentifier: data[data.allKeys.first as Any] as! String)
                }else if ElementKind == .MCElementKindHeader{
                    self.register(UINib.init(nibName: data.allKeys.first as! String, bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: data[data.allKeys.first as Any] as! String)
                }else if ElementKind == .MCElementKindFooter{
                    self.register(UINib.init(nibName: data.allKeys.first as! String, bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: data[data.allKeys.first as Any] as! String)
                }
            }
        }
        return self
    }
    //MARK: MC - Set PagingEnabled
    /// MC - 设置滑动分页
    ///
    /// - Parameter PagingEnabled: <#PagingEnabled description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcPagingEnabled(PagingEnabled: Bool) -> MCGridView{
        self.isPagingEnabled = PagingEnabled
        return self
    }
    //MARK: MC - Set ScrollDirection
    /// MC - 设置滑动方向
    ///
    /// - Parameter ScrollDirection: <#ScrollDirection description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetScrollDirection(ScrollDirection: UICollectionViewScrollDirection) -> MCGridView {
        wLayout.scrollDirection = ScrollDirection
        self.collectionViewLayout = wLayout
        return self
    }
    //MARK: MC - Set Hidden Shows Vertical 、Horizontal
    /// MC - 隐藏滑动指示器
    ///
    /// - Parameters:
    ///   - Vertical: <#Vertical description#>
    ///   - Horizontal: <#Horizontal description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetShowsVerticalHorizontalHidden(Vertical: Bool,Horizontal: Bool) -> MCGridView {
        self.showsVerticalScrollIndicator = Vertical
        self.showsHorizontalScrollIndicator = Horizontal
        return self
    }
    //MARK: MC - Sliding view callback
    /// MC - 监听滑动值
    ///
    /// - Parameter Scroll: <#Scroll description#>
    func mcReturnSlidingCallback(Scroll: @escaping MCReturnSlidingScroll) -> () {
        self.wScroll = Scroll
    }
    //MARK: MC - Sliding End view callback
    /// MC - 监听滑动结束
    ///
    /// - Parameter Scroll: <#Scroll description#>
    func mcReturnSlidingEndCallback(Scroll: @escaping MCReturnSlidingScroll) -> () {
        self.wEndScroll = Scroll
    }
    //MARK: MC - Click itme
    /// MC - 点击事件回调
    ///
    /// - Parameter ClickIndexPath: <#ClickIndexPath description#>
    func mcReturnClickIndexPath(ClickIndexPath: @escaping MCReturnClick) -> () {
        self.wSelendData = ClickIndexPath
    }
    //MARK: MC - Click TFViewBeginEditing
    /// MC - TFView 开始点击回调
    ///
    /// - Parameter TFViewBeginEditing: <#TFViewBeginEditing description#>
    func mcReturnTFViewBeginEditing(TFViewBeginEditing: @escaping MCClcikClassBlock) -> () {
        self.wBegin = TFViewBeginEditing
    }
    //MARK: MC - TFView ShouldChange
    /// MC - TFView 输入状态值自行处理 section: -1 footer：-2
    ///
    /// - Parameter block: <#block description#>
    func mcReturnItmeTFViewShouldChange(ShouldChangeBlock: @escaping MCTFViewShouldChange) -> () {
        self.wShouldChange = ShouldChangeBlock
    }
    //MARK: MC - Click TFView BeginEditing ShouldChange
    /// C - TFView 开始点击回调 + 输入状态值自行处理
    ///
    /// - Parameters:
    ///   - TFViewBeginEditing: <#TFViewBeginEditing description#>
    ///   - ShouldChangeBlock: <#ShouldChangeBlock description#>
    func mcReturnTFViewBeginEditingShouldChange(TFViewBeginEditing: @escaping MCClcikClassBlock,ShouldChangeBlock: @escaping MCTFViewShouldChange) -> () {
        self.wBegin = TFViewBeginEditing
        self.wShouldChange = ShouldChangeBlock
    }
    //MARK: MC - layout callback section
    /// MC - 设置区展示模块
    ///
    /// - Parameters:
    ///   - Sections: cell模块展示处理
    func mcLayoutSections(Sections: @escaping MCGridViewLayoutSection) -> () {
        self.wDataSoureBlock = Sections
    }
    //MARK: MC - Callback rows cell
    /// MC - 返回 cell
    ///
    /// - Parameter block: 单个模块处理
    func mcLayoutCell(CellBlock: @escaping MCGridViewLayoutCell) -> () {
        self.wLayoutCell = CellBlock
    }
    //MARK: MC - layout and callback section rows cell
    /// MC - 设置区展示模块 + 返回Cell
    ///
    /// - Parameters:
    ///   - Section: cell模块展示处理
    ///   - Cell: 单个模块处理
    func mcLayoutSectionsCell(Sections: @escaping MCGridViewLayoutSection,CellBlock: @escaping MCGridViewLayoutCell) -> () {
        self.wDataSoureBlock = Sections
        self.wLayoutCell = CellBlock
    }
    //MARK: MC - Callback section HFView
    /// MC - 处理 区头(indexPath.row = -1)、区尾(indexPath.row = -2)
    ///
    /// - Parameter HFView: 单个模块处理
    func mcLayoutSectionHFView(HFViewBlcok: @escaping MCGridViewLayoutHFCell)->(){
        self.wHFView = HFViewBlcok
    }
    //MARK: MC - Cell Click header: -1 footer:-2
    /// MC - Cell 点击事件
    ///
    /// - Parameter ClickCell: 点击事件回调
    func mcReturnClickCell(ClickCell: @escaping MCReturnClick) -> () {
        self.wClickCell = ClickCell
    }
    //MARK: MC - HFView Click header(indexPath.row:-1) footer(indexPath.row:-2)
    /// MC - 区头、区尾点击事件  区头indexPath.row:-1 区尾indexPath.row:-2
    ///
    /// - Parameter ClickHFView: Click callback
    func mcReturnClickHFView(ClickHFView: @escaping MCReturnClick) -> () {
        self.wClickHFView = ClickHFView
    }
    //MARK: MC - layout and callback section rows cell and Click
    /// MC - 设置区展示模块 + 返回Cell + 点击事件
    ///
    /// - Parameters:
    ///   - Section: cell模块展示处理
    ///   - Cell: 单个模块处理
    func mcLayoutSectionsCellClick(Sections: @escaping MCGridViewLayoutSection,CellBlock: @escaping MCGridViewLayoutCell,ClickCell: @escaping MCReturnClick) -> () {
        self.wDataSoureBlock = Sections
        self.wLayoutCell = CellBlock
        self.wClickCell = ClickCell
    }
    //MARK: MC - layout and callback section rows cell and Click
    /// MC - 设置区展示模块 + 返回Cell + 点击事件 header: -1 footer:-2
    ///
    /// - Parameters:
    ///   - Sections: cell模块展示处理
    ///   - CellBlock: 个模块处理
    ///   - ClickCell: cell点击
    ///   - ClickHFView: 区头区尾点击
    func mcLayoutSectionsCellClick(Sections: @escaping MCGridViewLayoutSection,CellBlock: @escaping MCGridViewLayoutCell,ClickCell: @escaping MCReturnClick,HFViewBlcok: @escaping MCGridViewLayoutHFCell,ClickHFView: @escaping MCReturnClick) -> () {
        self.wDataSoureBlock = Sections
        self.wLayoutCell = CellBlock
        self.wClickCell = ClickCell
        self.wHFView = HFViewBlcok
        self.wClickHFView = ClickHFView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.wScroll != nil {
            if wLayout.scrollDirection == UICollectionViewScrollDirection.vertical{
                self.wScroll?(scrollView.contentOffset.x)
            }else{
                self.wScroll?(scrollView.contentOffset.y)
            }
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.wDataSoure.wSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.SetLayoutBlocK(indexPath: IndexPath(row:0,section:section) as NSIndexPath, cell: NSNull())
        return self.wDataSoure.wRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: NSNull())
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.wDataSoure.wCellName, for: indexPath) as! MCGridViewCell
        self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: cell)
        if self.wLayoutCell != nil {
            self.wLayoutCell?(indexPath as NSIndexPath,cell)
        }
        cell.mcReturnClickCellData { (tag, data) in
            if self.wClickCell != nil{
                self.wClickCell?(self,indexPath as NSIndexPath,tag,data)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        self.SetLayoutBlocK(indexPath: IndexPath(row:0,section:section) as NSIndexPath, cell: NSNull())
        return self.wDataSoure.wCellMargin
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {(
        self.SetLayoutBlocK(indexPath: IndexPath(row:0,section: section) as NSIndexPath, cell: NSNull()))
        return self.wDataSoure.wSectionsLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: NSNull())
        return self.wDataSoure.wCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        self.SetLayoutBlocK(indexPath: IndexPath(row:0,section:section) as NSIndexPath, cell: NSNull())
        return self.wDataSoure.wCellMinimumInter
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        self.SetLayoutBlocK(indexPath: IndexPath(row:0,section:section) as NSIndexPath, cell: NSNull())
        return self.wDataSoure.wFooterSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        self.SetLayoutBlocK(indexPath: IndexPath(row:0,section:section) as NSIndexPath, cell: NSNull())
        return self.wDataSoure.wHeaderSize
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.SetLayoutBlocK(indexPath: indexPath as NSIndexPath, cell: NSNull())
        if self.wDataSoure.wHeaderIdName.count != 0 {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: self.wDataSoure.wHeaderIdName, for: indexPath) as! MCGridHFView
            headerView.backgroundColor = UIColor.white
            headerView.tag = indexPath.section
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHeaderClick(sender:)))
            headerView.isUserInteractionEnabled = true
            if headerView.gestureRecognizers == nil{
                headerView.addGestureRecognizer(tap)
            }
            headerView.mcReturnTFViewBeginEditing(BeginBlock: { (nil, tag) in
                if self.wBegin != nil{
                    self.wBegin?(IndexPath(row:-1,section:indexPath.section) as NSIndexPath,tag)
                }
            })
            if (self.wShouldChange != nil) {
                headerView.mcReturnTFViewShouldChange(block: { (nil, wClass, range, string, style) in
                    self.wShouldChange?(IndexPath(row:-1,section:indexPath.section) as NSIndexPath,wClass,range,string,style)
                })
            }
            if self.wHFView != nil{
                self.wHFView?(IndexPath(row: -1,section: indexPath.section) as NSIndexPath,headerView)
            }
            return headerView
        }else if self.wDataSoure.wFooterIdName.count != 0{
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionFooter", withReuseIdentifier: self.wDataSoure.wHeaderIdName, for: indexPath) as! MCGridHFView
            headerView.backgroundColor = UIColor.white
            headerView.tag = indexPath.section
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapFooterClick(sender:)))
            headerView.isUserInteractionEnabled = true
            if headerView.gestureRecognizers == nil{
                headerView.addGestureRecognizer(tap)
            }
            headerView.mcReturnTFViewBeginEditing(BeginBlock: { (nil, tag) in
                if self.wBegin != nil{
                    self.wBegin?(IndexPath(row:-2,section:indexPath.section) as NSIndexPath,tag)
                }
            })
            if (self.wShouldChange != nil) {
                headerView.mcReturnTFViewShouldChange(block: { (nil, wClass, range, string, style) in
                    self.wShouldChange?(IndexPath(row:-2,section:indexPath.section) as NSIndexPath,wClass,range,string,style)
                })
            }
            if self.wHFView != nil{
                self.wHFView?(IndexPath(row: -2,section: indexPath.section) as NSIndexPath,headerView)
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.wClickCell != nil) {
            self.wClickCell?(collectionView,indexPath as NSIndexPath,0,NSNull())
        }
    }
    @objc func tapHeaderClick(sender: UITapGestureRecognizer){
        if self.wClickHFView != nil {
            self.wClickHFView?(self,IndexPath(row:-1,section:(sender.view?.tag)!) as NSIndexPath,0,NSNull())
        }
    }
    @objc func tapFooterClick(sender: UITapGestureRecognizer){
        if self.wClickHFView != nil {
            self.wClickHFView?(self,IndexPath(row:-2,section:(sender.view?.tag)!) as NSIndexPath,0,NSNull())
        }
    }
    //MARK: MC - Set Layout blcok
    func SetLayoutBlocK(indexPath: NSIndexPath,cell: Any) -> () {
        if cell as? NSNull != NSNull() {
            let cell = cell as! MCGridViewCell
            cell.mcReturnTFViewBeginEditing(TFViewBeginBlock: { (nil, tag) in
                if self.wBegin != nil{
                    self.wBegin?(indexPath as NSIndexPath,tag)
                }
            })
            if (self.wShouldChange != nil) {
                cell.mcReturnTFViewShouldChange(TFViewShouldChangeBlock: { (nil, wClass, range, string, style) in
                    self.wShouldChange?(indexPath as NSIndexPath, wClass, range, string, style)
                })
            }
        }else{
            if (self.wDataSoureBlock != nil) {
                self.wDataSoureBlock?(indexPath,self.wDataSoure)
            }
        }
    }
    var wDataSoure = MCGridDataSource()
    var wLayout = UICollectionViewFlowLayout()
    var wDataSoureBlock: MCGridViewLayoutSection?
    var wScroll: MCReturnSlidingScroll?
    var wEndScroll: MCReturnSlidingScroll?
    var wSelendData: MCReturnClick?
    var wBegin: MCClcikClassBlock?
    var wClickHFView: MCReturnClick?
    var shouldChangeStyle = MCellShouldChangeStyle()
    var wShouldChange: MCTFViewShouldChange?
    var wClickCell: MCReturnClick?
    var wLayoutCell: MCGridViewLayoutCell?
    var wHFView: MCGridViewLayoutHFCell?
}
//MARK:************************************* MCGridDataSource
class MCGridDataSource: NSObject {
//MARK:****************** GridView Cell back
    //MARK: MC - Set section in cell rows number
    /// MC - 设置区中的cell的数量
    ///
    /// - Parameter mcRows: <#mcRows description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetRows(Rows: NSInteger) -> MCGridDataSource {
        self.wRows = Rows
        return self
    }
    //MARK: MC - Set cell Bundle name xib
    /// MC - 设置Cell Bundle name xib
    ///
    /// - Parameter mcItmeName: <#mcItmeName description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetItmeBundleName(ItmeBundleName: String,ElementKind: MCElementKind) -> MCGridDataSource {
        if ElementKind == .MCElementKindCell{
            self.wCellName = ItmeBundleName
        }else if ElementKind == .MCElementKindHeader{
            self.wHeaderIdName = ItmeBundleName
        }else if ElementKind == .MCElementKindFooter{
            self.wFooterIdName = ItmeBundleName
        }
        self.wCellName = ItmeBundleName
        return self
    }
    //MARK: MC - Set Itme size
    /// MC - 设置Itme的大小
    ///
    /// - Parameter CellSize: <#FooterSize description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetItmeSize(ItmeSize: CGSize,ElementKind: MCElementKind) -> MCGridDataSource {
        if ElementKind == .MCElementKindCell{
            self.wCellSize = ItmeSize
        }else if ElementKind == .MCElementKindHeader{
            self.wHeaderSize = ItmeSize
        }else if ElementKind == .MCElementKindFooter{
            self.wFooterSize = ItmeSize
        }
        return self
    }
    //MARK: MC - Set Cell MinimumInter
    /// MC - 设置区之间的间距
    ///
    /// - Parameter CellMinimumInter: <#CellMinimumInter description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetCellMinimumInter(CellMinimumInter: CGFloat) -> MCGridDataSource {
        self.wCellMinimumInter = CellMinimumInter
        return self
    }
    //MARK: MC - Set Sections LineSpacing
    /// MC - 设置区之间的间距
    ///
    /// - Parameter SectionsLineSpacing: <#CellMinimumInter description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetSectionsLineSpacing(SectionsLineSpacing: CGFloat) -> MCGridDataSource {
        self.wSectionsLineSpacing = SectionsLineSpacing
        return self
    }
    //MARK: MC - Set Cell section Margin
    /// MC - 设置每个区Cell的 Margin
    ///
    /// - Parameter SectionMargin: <#SectionMargin description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetSectionCellMargin(SectionMargin: UIEdgeInsets) -> MCGridDataSource {
        self.wCellMargin = SectionMargin
        return self
    }
    //MARK:****************** GridView Header、Footer View back
    //MARK: MC - Set header section Bundle Name xib
    /// MC - 设置区头Bundle Name xib
    ///
    /// - Parameter mcHeaderName: <#mcHeaderName description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetHeaderBundleNameIdentifier(HeaderNameIdentifier: String) -> MCGridDataSource {
        self.wHeaderIdName = HeaderNameIdentifier
        return self
    }
    //MARK: MC - Set header in section size
    /// MC - 设置区头的大小
    ///
    /// - Parameter HeaderSize: <#FooterSize description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetHeaderSize(HeaderSize: CGSize) -> MCGridDataSource {
        self.wHeaderSize = HeaderSize
        return self
    }
    //MARK: MC - Set footer in section Bundle Name xib
    /// MC - 设置区尾Bundle Name xib
    ///
    /// - Parameter mcFooterName: <#mcFooterName description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetFooterBundleNameIdentifier(FooterIdentifier: String) -> MCGridDataSource {
        self.wFooterIdName = FooterIdentifier
        return self
    }
    //MARK: MC - Set footer in section size
    /// MC - 设置区尾的大小
    ///
    /// - Parameter FooterSize: <#FooterSize description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func mcSetFooterSize(FooterSize: CGSize) -> MCGridDataSource {
        self.wFooterSize = FooterSize
        return self
    }
    var wSections            = NSInteger()
    var wRows                = NSInteger()
    var wCellName            = String()
    var wCellSize            = CGSize()
    var wCellMinimumInter    = CGFloat()
    var wCellMargin          = UIEdgeInsets()
    var wSectionsLineSpacing = CGFloat()
    

    var wHeaderIdName        = String()
    var wFooterIdName        = String()
    var wHeaderSize          = CGSize()
    var wFooterSize          = CGSize()
    
}
//MARK:************************************* MCGridCell
class MCGridViewCell: UICollectionViewCell, UITextFieldDelegate, UITextViewDelegate,UISearchBarDelegate{
    @IBOutlet weak var mcTFView: UITextField!
    @IBOutlet weak var mcTxtView: UITextView!
    @IBOutlet weak var mcSearchBar: UISearchBar!
    override func awakeFromNib(){
        super.awakeFromNib()
        if (mcTFView != nil){
            mcTFView.delegate = self
        }
        if (mcTxtView != nil) {
            mcTxtView.delegate = self
        }
        if (mcSearchBar != nil) {
            mcSearchBar.delegate = self
        }
    }
    //MARK: MC - Set the click event callback data block
    /// MC - 数据传递(按钮点击事件)
    ///
    /// - Parameter block: <#block description#>
    func mcReturnClickCellData(ClickBlock: @escaping MCReturnItme) -> () {
        self.wClick = ClickBlock
    }
    //MARK: MC - TFView start the editor callback
    /// MC - TFView 开始编辑调用
    ///
    /// - Parameter block: <#block description#>
    func mcReturnTFViewBeginEditing(TFViewBeginBlock: @escaping MCClcikClassBlock) -> () {
        self.wBegin = TFViewBeginBlock
    }
    //MARK: MC - TFView edits state value deal callback
    /// MC - TFView 编辑状态值回调
    ///
    /// - Parameter block: <#block description#>
    func mcReturnTFViewShouldChange(TFViewShouldChangeBlock: @escaping MCTFViewShouldChange) -> () {
        self.wShouldChange = TFViewShouldChangeBlock;
    }
    @IBAction func buttonClick(_ sender: UIButton){
        if (self.wClick != nil) {
            self.wClick?(sender.tag,sender)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),textField.tag)
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(textField.tag,textField.text as Any)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textField, range, string,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),textView.tag)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textView, range, text,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(textView.tag,textView.text as Any)
        }
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),searchBar.tag)
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textView, range, text,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.endEditing(true)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(searchBar.tag,searchBar.text as Any)
        }
        return true
    }
    var wBegin: MCClcikClassBlock?
    var wShouldChange: MCTFViewShouldChange?
    var wClick: MCReturnItme?
    var shouldChangeStyle: MCellShouldChangeStyle!
}
//MARK:************************************* MCGridHFView
class MCGridHFView: UICollectionReusableView, UITextFieldDelegate, UITextViewDelegate,UISearchBarDelegate{
    @IBOutlet weak var mcTFView: UITextField!
    @IBOutlet weak var mcTxtView: UITextView!
    @IBOutlet weak var mcSearchBar: UISearchBar!
    override func awakeFromNib(){
        super.awakeFromNib()
        if (mcTFView != nil){
            mcTFView.delegate = self
        }
        if (mcTxtView != nil) {
            mcTxtView.delegate = self
        }
        if (mcSearchBar != nil) {
            mcSearchBar.delegate = self
        }
    }
    //MARK: MC - Set the click event callback data block
    /// MC - 数据传递(按钮点击事件)
    ///
    /// - Parameter block: <#block description#>
    func mcReturnCellData(block: @escaping MCReturnItme) -> () {
        self.wClick = block
    }
    //MARK: MC - TFView start the editor callback
    /// MC - TFView 开始编辑调用
    ///
    /// - Parameter block: <#block description#>
    func mcReturnTFViewBeginEditing(BeginBlock: @escaping MCClcikClassBlock) -> () {
        self.wBegin = BeginBlock
    }
    //MARK: MC - TFView edits state value deal callback
    /// MC - TFView 编辑状态值回调
    ///
    /// - Parameter block: <#block description#>
    func mcReturnTFViewShouldChange(block: @escaping MCTFViewShouldChange) -> () {
        self.wShouldChange = block;
    }
    @IBAction func buttonClick(_ sender: UIButton){
        if (self.wClick != nil) {
            self.wClick?(sender.tag,sender)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),textField.tag)
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(textField.tag,textField.text as Any)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textField, range, string,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),textView.tag)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textView, range, text,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(textView.tag,textView.text as Any)
        }
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if self.wBegin != nil {
            self.wBegin?(NSIndexPath(),searchBar.tag)
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.wShouldChange != nil {
            self.wShouldChange?(NSIndexPath(), textView, range, text,self.shouldChangeStyle)
            return self.shouldChangeStyle.wIsOk;
        }
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.endEditing(true)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if (self.wClick != nil) {
            self.wClick?(searchBar.tag,searchBar.text as Any)
        }
        return true
    }
    var wBegin: MCClcikClassBlock?
    var wShouldChange: MCTFViewShouldChange?
    var wClick: MCReturnItme?
    var shouldChangeStyle: MCellShouldChangeStyle!
}
