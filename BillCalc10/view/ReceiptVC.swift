//
//  ViewController.swift
//  BillCalc10
//
//  Created by Moiz Khan on 2019-10-18.
//  Copyright © 2019 Moiz Khan. All rights reserved.
//

import UIKit

class ReceiptVC: UIViewController {

    @IBOutlet var accountNumber: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var weekdayCharges: UILabel!
    @IBOutlet var eveningCharges: UILabel!
    @IBOutlet var videoCallCharges: UILabel!
    @IBOutlet var totalCharges: UILabel!
    
    //Declared so we can reference CoreData functions
    let billController = BillController()
    var currentUserBill : String! = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAllBill()
        // Do any additional setup after loading the view.
    }

    
    //Fetch all records and find the record that matches the Account ID stored in currentUserBill
    func fetchAllBill(){
        var allbills = self.billController.getBills()
        
        if (allbills != nil){
            for bill in allbills!{
                //If User is found then display the data to the user.
                if((bill.value(forKey:"accountNumber") as! String) == currentUserBill){
                    accountNumber.text = currentUserBill
                    email.text = bill.value(forKey:"email") as! String
                    weekdayCharges.text = "$ " + String(bill.value(forKey : "weekdayCharges") as! Float)
                    eveningCharges.text = "$ " + String(bill.value(forKey : "eveningCharges") as! Float)
                    videoCallCharges.text = "$ " + String(bill.value(forKey : "videoCallCharges") as! Float)
                    totalCharges.text = "$ " + String(bill.value(forKey : "totalBill") as! Float)
                }
                
            }
        }
    }

}

