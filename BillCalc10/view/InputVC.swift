//
//  InputVC.swift
//  BillCalc10
//
//  Created by Moiz Khan on 2019-10-18.
//  Copyright © 2019 Moiz Khan. All rights reserved.
//

import UIKit

class InputVC: UIViewController {

    @IBOutlet var accountNumber: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var weekdayMins: UITextField!
    @IBOutlet var eveningMins: UITextField!
    @IBOutlet var videoCallMins: UITextField!
    
    
    let billController = BillController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateUsage(_ sender: UIButton) {
        print("Calculating Usage")
        //Retreive the data from the user, incase of no data entered there are default values set.
        var id = accountNumber.text ?? "000"
        var emailAdd = email.text ?? "domain@email.com"
        var weekdayUse = Int(weekdayMins.text!) ?? 1
        var eveningUse = Int(eveningMins.text!) ?? 1
        var videoCallUse = Int(videoCallMins.text!) ?? 1
        
        //Caluculations to be done
        var weekCost: Float! = 0.0
        var eveningCost : Float! = 0.0
        var total: Float! = 0.0
        var videoCost: Float! = 0.0
        
        
        //Check if the weekday Minutes are below 500, if not then calculate charges above 500 minutes only.
        if (weekdayUse > 500){
            weekdayUse = weekdayUse - 500
            weekCost = Float(weekdayUse) * 0.35
        }else{
            weekdayUse = 0
            weekCost = 0.0
        }
        
        //Finish calculations for bill
        eveningCost = Float(eveningUse) * 0.25
        videoCost = Float(videoCallUse) * 0.40
        total = weekCost + eveningCost + videoCost
        
        //Create Bill as an object so we can store it into the Core Data
        var bill = Bill(accountNumber: id, email : emailAdd, weekdayUsage: weekdayUse, eveningUsage: eveningUse, videoCalling: videoCallUse, totalBill: total, weekdayCharges: weekCost, eveningCharges : eveningCost, videoCallCharges : videoCost)
        
        //Setup navigation values used to store values in the next class so its ready to use when needed
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let billVC = mainSB.instantiateViewController(withIdentifier: "ReceiptScene") as! ReceiptVC
        
        //Insert bill into core data table
        billController.insertBill(newBill : bill)
        
        //Save account id of user to the next VC in currentUserBill variable
        billVC.currentUserBill = id
        
        //Navigate to next screen
        navigationController?.pushViewController(billVC, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
