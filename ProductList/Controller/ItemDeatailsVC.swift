//
//  ItemDeatailsVC.swift
//  ProductList
//
//  Created by Alif on 22/09/2017.
//  Copyright © 2017 Alif. All rights reserved.
//

import UIKit
import CoreData

class ItemDeatailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var details: UITextField!
    @IBOutlet weak var imageThumb: UIImageView!
    
    var stores = [Store]()
    var itemToEdit:  Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topBar = navigationController?.navigationBar.topItem {
            topBar.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //generateStore()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        let store = stores[row]
        return store.name
    
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // update when selected
    }
    
    func generateStore() {
        
        let store = Store(context: context)
        store.name = "Apple"
        
        let store1 = Store(context: context)
        store1.name = "Sony"
        
        let store2 = Store(context: context)
        store2.name = "Oppo"
        
        ad.saveContext()
        
    }

   func getStores() {
    
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
    
        do {
        
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        
        } catch  {
            let error = NSError()
            print("\(error)")
    
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = imageThumb.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
        
        } else {
            
            item = itemToEdit
            
        }
        
        item.toImage = picture
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = details.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            details.text = item.details
            
            if let img = item.toImage as? Image {
                imageThumb.image = img.image as? UIImage
            }
            
            if let store = item.toStore as? Store {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
        }
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func addImage(_ sender: UIButton) {
     
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageThumb.image = img
        }
    
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
