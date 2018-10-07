//
//  ProductViewController.swift
//  MLAR
//
//  Created by K on 10/6/18.
//  Copyright © 2018 K. All rights reserved.
//

//import Foundation
import UIKit
import AVFoundation
import Vision

class ProductViewController: UIViewController {
    
    @IBOutlet var productView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var productPhoto: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    var productID: String!
    var productCatalog: [String: [String: Any]]!
    
    
    @IBAction func dismissProductView(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Read the product catalog from the plist file into the dictionary.
        if let path = Bundle.main.path(forResource: "ProductCatalog", ofType: "plist") {
//            print("get it")
//            print(NSDictionary(contentsOfFile: path))
            self.productCatalog = NSDictionary(contentsOfFile: path) as? [String: [String: Any]]
        }
//        print("HEre is ")
//        print(productCatalog)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Give the view rounded corners.
        productView.layer.cornerRadius = 10
        productView.layer.masksToBounds = true
//        print(productCatalog)
        let itemsCatalog = self.productCatalog.keys.sorted()
        if productID != nil {
            if !itemsCatalog.contains(productID) {
                label.text = "Unvailable"
                descriptionText.text = "We are updating this item. Please check it later."
                productPhoto.image = UIImage(named:"loading.gif")
            }
            guard productCatalog[productID] != nil else {
                return
            }
            
            label.text = productCatalog[productID]?["label"] as? String
            descriptionText.text = productCatalog[productID]?["description"] as? String
            if let productImage = UIImage(named: productID + ".jpg") {
                productPhoto.image = productImage
            }
        }
    }
}
