//
//  SaleDetailDataLineAccountSearchViewController.swift
//  Q6IosClient
//
//  Created by yang wulong on 14/06/2016.
//  Copyright © 2016 q6. All rights reserved.
//

import UIKit

class SaleDetailDataLineAccountSearchViewController:  UIViewController , Q6WebApiProtocol,UITableViewDelegate ,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var AccountSearchBox: UISearchBar!
    
    var originalSectionsSortDic: [Int:String] = [0:"Income" , 1:"Other Income",2:"Cost of Sales",3:"Bank Account",4:"Current Asset",5:"Non-Current Asset",6:"Current Liability",7:"Non-Current Liability",8:"Equity"]
    
    var accountListData = [ScreenSectionSortDetailForAccount]()
    
    @IBOutlet weak var Q6ActivityIndicator: UIActivityIndicatorView!
    
    var pageIndex: Int = 1
    var pageSize: Int = 2000
    var searchText: String = ""
    var dataRequestSource = ""
    var attachedURL = String()
    
    var selectedAccountView:AccountView?
    
    weak var delegate : Q6GoBackFromView?
    var fromCell = String()
    
    @IBOutlet weak var AccountListTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        intitalAccounListData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AccountListTableView.delegate = self
        self.AccountListTableView.dataSource = self
        self.AccountSearchBox.delegate = self
        Q6ActivityIndicator.startAnimating()
        selectedAccountView = nil
        let q6CommonLib = Q6CommonLib(myObject: self)
        
        setAttachedURL(AccountNameOrAccountNo: "" ,IsPurchase: false,IsSale: true,IsLoadCurrentBalance:false, IsLoadInactive:false,PageSize: pageSize,PageIndex: pageIndex )
        q6CommonLib.Q6IosClientGetApi(ModelName: "Account", ActionName: "GetChartOfAccountList", attachedURL: attachedURL)
        
        setControlAppear()
        // Do any additional setup after loading the view.
    }
    
    func setControlAppear()
    {
        
        AccountSearchBox.layer.cornerRadius = 2;
        AccountSearchBox.layer.borderWidth = 0.1;
        AccountSearchBox.layer.borderColor = UIColor.black.cgColor
    }
    
    func intitalAccounListData() {
        
        if accountListData.count == 0 {
            
            for i in 0..<8
            {
                let screenSectionSortDetailForAccount = ScreenSectionSortDetailForAccount()
                screenSectionSortDetailForAccount.AccountType = originalSectionsSortDic[i]!
                screenSectionSortDetailForAccount.sortNo = i
                
                print ("screenSectionSortDetailForAccount.AccountType" + screenSectionSortDetailForAccount.AccountType)
                
                
                print ("screenSectionSortDetailForAccount.sortNo " + screenSectionSortDetailForAccount.sortNo.description)
                
                accountListData.append(screenSectionSortDetailForAccount)
            }
            
            print("accountListDate.count" + accountListData.count.description)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSectionCount()-> Int {
        var count = 0
        if accountListData.count != 0
        {
            
            
            for item in accountListData
            {
                if item.accountViewArray.count != 0
                {
                    count = count + 1
                }
            }
        }
        
        return count
    }
    
    func setAttachedURL(AccountNameOrAccountNo: String ,IsPurchase: Bool,IsSale: Bool,IsLoadCurrentBalance:Bool, IsLoadInactive:Bool,PageSize: Int,PageIndex: Int )
    {
        attachedURL = "&AccountNameOrAccountNo=" + AccountNameOrAccountNo + "&IsPurchase=" + String(IsPurchase) + "&IsSale=" + String(IsSale)  + "&IsLoadCurrentBalance=" + String(IsLoadCurrentBalance) + "&IsLoadInactive=" + String(IsLoadInactive) + "&PageSize=" + String(PageSize) + "&PageIndex=" + String(pageIndex)
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let SectionCount = getSectionCount()
        print("getSectionCount" + SectionCount.description)
        return getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let accountViewArray = accountListData[section].accountViewArray
        
        print("Section" + section.description + "accountViewArray.count" + accountViewArray.count.description)
        return accountViewArray.count
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "AccountNameCell", for: indexPath) as! SaleDetailDataLineAccountSearchTableViewCell
        let accountView = accountListData[indexPath.section].accountViewArray[indexPath.row]
        cell.lblAccountNameWithAccountNo.text = accountView.AccountNameWithAccountNo
        print("AccountNameWithAccountNo" + accountView.AccountNameWithAccountNo)
        //        cell.lblSupplierID.hidden = true
        //
        //
        //        cell.lblSupplierName.text =  supplierData[indexPath.row].SupplierName
        //
        //        cell.lblSupplierID.text =  supplierData[indexPath.row].SupplierID
        
        // Configure the cell...
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return accountListData[section].AccountType
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedAccountView = nil
        
        print("selected indexpath" + indexPath.row.description)
        _ = tableView.cellForRow(at: indexPath as IndexPath) as! SaleDetailDataLineAccountSearchTableViewCell
        
        let selAccountView = accountListData[indexPath.section].accountViewArray[indexPath.row]
        
        selectedAccountView = selAccountView
        
        AccountSearchBox.resignFirstResponder()
    }
    func dataLoadCompletion(data:NSData?, response:URLResponse?, error:NSError?) -> AnyObject
    {
        var postDicData :[String:AnyObject]
        
        do {
            if dataRequestSource == "Search" {
                selectedAccountView = nil
                accountListData.removeAll()
                intitalAccounListData()
                
            }
            postDicData = try  JSONSerialization.jsonObject(with: data! as Data, options: []) as! [String:AnyObject]
            
            var returnData = postDicData["AccountList"] as! [[String : AnyObject]]
            print("returnDate Count" + returnData.count.description)
            
            for i in 0  ..< returnData.count {
                
                //
                //                print("no i =" + i.description)
                var dataItem = returnData[i]
                //
                let accountView = AccountView()
                accountView.AccountID = dataItem["AccountID"] as! String
                accountView.AccountName = dataItem["AccountName"] as! String
                accountView.AccountNameWithAccountNo = dataItem["AccountNameWithAccountNo"] as! String
                accountView.AccountType = dataItem["AccountType"] as! String
                accountView.SortNo = dataItem["SortNo"] as! Int
                accountView.TaxCodeID = dataItem["TaxCodeID"] as? String
                accountView.TaxCodeName = dataItem["TaxCodeName"] as! String
                accountView.TaxRate = dataItem["TaxRate"] as! Double
                accountView.TaxCodePurpose = dataItem["TaxCodePurpose"] as! String
                print("accountView.TaxCodePurpose" + accountView.TaxCodePurpose )
                
                //                if let TaxCodeName = accountView.TaxCodeName {
                
                
                
                for item in accountListData
                {
                    print("item.accounttype" + item.AccountType)
                    if accountView.AccountType == item.AccountType
                    {
                        let i = item.sortNo
                        
                        var accountViewArray =  accountListData[i].accountViewArray
                        accountViewArray.append(accountView)
                        accountListData[i].accountViewArray = accountViewArray
                        print("accountListData[" + i.description + "].accountViewArray" + accountListData[i].accountViewArray.count.description)
                        print("AccountType  " + accountView.AccountType + "AccountName" + accountView.AccountNameWithAccountNo)
                    }
                }
                //  print("accountView.TaxRate" + accountView.TaxRate.description)
                //                }
                //                else {
                //                   print("accountView.TaxCodeID nil")
                //                }
                //                supplier.SupplierID = dataItem["SupplierID"] as! String
                //
                //                print("SupplierID" + supplier.SupplierID)
                //
                //                supplier.SupplierName = dataItem["SupplierName"] as! String
                //                print("SupplierName" + supplier.SupplierName)
                //
                //
                //accountListData.append(<#T##newElement: Element##Element#>)
                //
                //                printFields(purchasesTransactionListViewDataItem)
            }
            
            //            print("supplier Date Count" + supplierData.count.description)
            //
            recountandSortaccountListData()
      DispatchQueue.main.async {
                self.AccountListTableView.reloadData()
                self.Q6ActivityIndicator.hidesWhenStopped = true
                self.Q6ActivityIndicator.stopAnimating()
                self.AccountSearchBox.resignFirstResponder()
                
            }
            
            
            
        } catch  {
            print("error parsing response from POST on /posts")
            
            return "" as AnyObject
        }
        
        return "" as AnyObject
    }
    
    func  recountandSortaccountListData()
    {
        print(" Before accountListData.count" + accountListData.count.description)
        _ = [Int]()
        var tempAccountListData = [ScreenSectionSortDetailForAccount]()
        for i in 0..<accountListData.count
        {
            let screenSectionSortDetailForAccount = accountListData[i]
            
            if screenSectionSortDetailForAccount.accountViewArray.count != 0
            {
                
                tempAccountListData.append(screenSectionSortDetailForAccount)
            }
            
        }
        
        if tempAccountListData.count > 0
        {
            accountListData = tempAccountListData
        }
        
        print(" after accountListData.count" + accountListData.count.description)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText
        //
        if searchText.length == 0 {
            
            
            
            let q6CommonLib = Q6CommonLib(myObject: self)
            
            accountListData.removeAll()
            
            dataRequestSource = "Search"
            
            setAttachedURL(AccountNameOrAccountNo: searchText ,IsPurchase: false,IsSale: true,IsLoadCurrentBalance:false, IsLoadInactive:false,PageSize: pageSize,PageIndex: pageIndex )
            q6CommonLib.Q6IosClientGetApi(ModelName: "Account", ActionName: "GetChartOfAccountList", attachedURL: attachedURL)
            
        }
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        let q6CommonLib = Q6CommonLib(myObject: self)
        
        pageIndex = 1
        accountListData.removeAll()
        
        
        dataRequestSource = "Search"
        setAttachedURL(AccountNameOrAccountNo: searchText ,IsPurchase: false,IsSale: true,IsLoadCurrentBalance:false, IsLoadInactive:false,PageSize: pageSize,PageIndex: pageIndex )
        q6CommonLib.Q6IosClientGetApi(ModelName: "Account", ActionName: "GetChartOfAccountList", attachedURL: attachedURL)
        
        searchBar.resignFirstResponder()
        
    }
    
    @IBAction func DoneButtonClicked(sender: AnyObject) {
        
        if selectedAccountView != nil {
            
            self.delegate?.sendGoBackFromSaleDetailDataLineAccountSearchView(fromView: "SaleDetailDataLineAccountSearchViewController" ,forCell :fromCell,accountView: selectedAccountView!)
            //
            
            _ = navigationController?.popViewController(animated: true)
            
            
        }
        else{
            
            Q6CommonLib.q6UIAlertPopupController(title: "Information Message", message: "You haven't select a account", viewController: self)
            
        }
    }
    @IBAction func CancelButtonClicked(sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
