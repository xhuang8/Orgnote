//
//  CreateItemViewController.swift
//  Orgnote
//
//  Created by paul on 11/29/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit

var Locations: [String] = []

class CreateItemViewController: UIViewController {
    
    
    @IBOutlet weak var newItemImage: UIButton!
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var categoryInput: UITextField!
    
    @IBOutlet weak var locationInput: UITextField!
    //@IBOutlet weak var descriptionInput: UITextField!
    
    @IBOutlet weak var descriptionInput: UITextView!
    
    
    var itemsByLocation: [[String:Any]] = []
    
    //item_Image
    var item_Image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("")
        if (item_Image != nil) {
            self.newItemImage.setBackgroundImage(item_Image, for: .normal)
        }
       // newItemImage.image = item_Image;
        // Do any additional setup after loading the view.
        
        
    }
    
    //click to pick up photo form album
    //Create a controller and navigate to this controller
    @IBAction func newItemImageClick(_ sender: Any) {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        addItem()
    }
    
    func addItem(){
        //[name: String, category: String, location: String, description: String]
        let name = nameInput.text! as String
        let category = categoryInput.text
        let location = locationInput.text! as String
        let description = descriptionInput.text
        let item = Item(name: name, category: category ?? "None", location: location, description: description ?? "None")
        
        //print(item.itemData)
        //print(item.itemData["location"] as! String)
        //let location = item.itemData["location"] as! String
        let itemData = item.itemData
        updateItem(location, itemData)
        dismiss(animated: true, completion: nil)
        
//        if location in location list{
//            load the list of the location
//            add item to the list
//
//        }else{
//            update location to location list
//            as new location list
//        }
//        save to list of location to device
    }
    
    func updateItem(_ location: String, _ itemData: [String:Any]){
        if Locations.contains(location) {
            //get the list of the location, update the list, and then save
            itemsByLocation = UserDefaults.standard.object(forKey: location) as![[String:Any]]
            //print("location exist")
            itemsByLocation.append(itemData)
            print(itemsByLocation)
            //save itemsByLocation
            UserDefaults.standard.set(itemsByLocation, forKey: location)
            
        }else{
            //append and save
            Locations.append(location)
            
            UserDefaults.standard.set(Locations, forKey: "Locations")
            itemsByLocation.append(itemData)

            UserDefaults.standard.set(itemsByLocation, forKey: location)
            
            
        }
        
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
