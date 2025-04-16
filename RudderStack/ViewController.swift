//
//  ViewController.swift
//  RudderStack
//
//  Created by Aditya Sinha on 14/04/25.
//

import UIKit
import Rudder
import Rudder_CleverTap

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var OnUser: UIButton!
    @IBAction func OnUserLogin(_ sender: Any) {
        let date = Date()
        let egFloat: NSNumber = 120.4
        let egDouble: NSNumber = 333.6020814126
        let egInt: NSNumber = 333
        let egLong: NSNumber = 1234
        let egBoolean: NSNumber = true
        let name = "TestUser"

        RSClient.sharedInstance()?.identify("test_user_identity", traits: [
            "name": name,
            "pincode": "578900",
            "email": "test@gmail.com",
            "state": "Karnataka",
            "city": "Bangalore",
            "country": "India",
            "phone": "+911255555555",
            "gender": "F",
            "birthday": date,
            "float Swift": egFloat,
            "double Swift": egDouble,
            "Integer Swift": egInt,
            "Long Swift": egLong,
            "Boolean Swift": egBoolean
        ])

    }
    @IBOutlet weak var Charged: UIButton!
    @IBOutlet weak var Event: UIButton!
    @IBAction func ChargedEvent(_ sender: Any) {
        let properties: [String: Any] = [
            "Amount": 100,
            "orderId": "199",
            "currency": "USD",
            "products": [
                [
                    "productId": "12",
                    "name": "Book",
                    "price": 22,
                    "quantity": 3
                ],
                [
                    "product_id": "13",
                    "name": "Shoes",
                    "price": 50,
                    "quantity": 1
                ]
            ]
        ]

        RSClient.sharedInstance()?.track("Order Completed", properties: properties)

    }
    @IBAction func EventPushed(_ sender: Any) {
        RSClient.sharedInstance()?.track("Event Pushed", properties: [
            "App": "iOS",
            "Language": "Swift"
        ])
    }
}

