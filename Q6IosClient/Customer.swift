//
//  Supplier.swift
//  Q6IosClient
//
//  Created by yang wulong on 5/05/2016.
//  Copyright © 2016 q6. All rights reserved.
//

import Foundation

public class Customer {
    
    var CustomerID = String()
    var CustomerName:String = ""
    var Title:String?
      var CreateDate = NSDate()
    var FirstName:String?
    var LastName:String?
    var Email:String?
    var Phone:String?
    var Fax:String?
    var Memos:String?
    
    var DefaultDueDate = Int()
    var DefaultDueDateOption = Int()
    
    var BSBNumber:String?
    var BankAccountNumber:String?
    var BankAccountName:String?
    var StatementText:String?
    var PaymentMemos:String?
    var DefaultSalesAccountID:String?
    var DefaultSalesAccountNameWithAccountNo:String?
    var ABN:String?
    var DefaultSalesTaxCodeID:String?
    var DefaultSalesTaxCodeName = String()
    var DefaultSalesTaxCodeRate = Double()
    var DefaultSalesTaxCodePurpose = String()
    
    var DefaultSalesDiscount = Double()
    var PhysicalAddress:String?
    var PhysicalAddressLine2:String?
    var PhysicalCity:String?
    var PhysicalState:String?
    var PhysicalPostalCode:String?
    var PhysicalCountry:String?
    var IsSameAsPhysicalAddress:Bool?
    var PostalAddress:String?
    var PostalAddressLine2:String?
    var PostalCity:String?
    var PostalState:String?
    var PostalPostalCode:String?
    var PostalCountry:String?
    var IsSameAsPostalAddress:Bool?
    var ShippingAddress:String?
    var ShippingAddressLine2:String?
    var ShippingCity:String?
    var ShippingState:String?
    var ShippingPostalCode:String?
    var ShippingCountry:String?
    var IsInactive = Bool()
    
    
    init(){
        self.ABN = ""
        self.BankAccountName = ""
        self.BankAccountNumber = ""
        self.BSBNumber = ""
        self.CreateDate = NSDate()
        self.DefaultSalesAccountID = nil
        self.DefaultSalesTaxCodeID = nil
        self.DefaultSalesDiscount = 0
        self.DefaultDueDate = 0
        self.DefaultDueDateOption = 0
        self.Email = ""
        self.Fax = ""
        self.FirstName = ""
        self.IsInactive = false
        self.IsSameAsPostalAddress = true
        self.IsSameAsPhysicalAddress = true
        self.LastName = ""
        self.Memos = ""
        self.PaymentMemos = ""
        self.Phone = ""
        self.PhysicalAddress = ""
        self.PhysicalAddressLine2 = ""
        self.PhysicalCity = ""
        self.PhysicalCountry = "Australia"
        self.PhysicalPostalCode = ""
        self.PhysicalState = ""
        self.PostalAddress = ""
        self.PostalAddressLine2 = ""
        self.PostalCity = ""
        self.PostalCountry = "Australia"
        self.PostalPostalCode = ""
        self.PostalState = ""
        self.ShippingAddress = ""
        self.ShippingAddressLine2 = ""
        self.ShippingCity = ""
        self.ShippingCountry = "Australia"
        self.ShippingPostalCode = ""
        self.ShippingState = ""
        self.StatementText = ""
        self.CustomerName = ""
        self.CustomerID = NSUUID().uuidString
        self.Title = ""
    }
}
