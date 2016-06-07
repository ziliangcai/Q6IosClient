//
//  PurchasesTransactionsHeader.swift
//  Q6IosClient
//
//  Created by yang wulong on 2/05/2016.
//  Copyright © 2016 q6. All rights reserved.
//

import Foundation

public class PurchasesTransactionsHeader
{
    
    var PurchasesTransactionsHeaderID  = NSUUID().UUIDString //: String = NSUUID().UUIDString
    var ReferenceNo = String()
    var PurchasesType: String = "Bill"
    var PurchasesStatus :String = "Open"
    var TransactionDate = NSDate()
    var CreateTime = NSDate()
    var LastModifiedTime = String()
    var SupplierID = String()
    var ShipToAddress = String()
    var SupplierInv = String()
    var Memo :String = ""
    var ClosedDate = NSDate?()
    var SubTotal = Double()
    var TaxTotal = Double()
    var TotalAmount = Double()
    var DueDate = NSDate?()
    var TaxInclusive: Bool = true
    var IsDeleted = Bool()
    var IsCreatedByRecurring = Bool()
    var RecurringTemplateID = String?()
    var HasLinkedDoc = Bool()
    
   
}