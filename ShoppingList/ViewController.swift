//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jonatan Ortiz on 21/02/22.
//

import UIKit

 
class ViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    var alert = UIAlertController()
    var pickerView = UIPickerView()
    let defaults = UserDefaults.standard
    var selectedCategory: Categories = Categories(rawValue: 0)!
    var categoriesArray: [[String]]?
    var initialAlert = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        initialConfig()
    }
    
    func initialConfig() {
        if defaults.array(forKey: "categoriesArray") as? [[String]] == nil {
            categoriesArray = Categories.allCases.map { _ in [] }
            defaults.set(categoriesArray, forKey: "categoriesArray")
            defaults.synchronize()
            addToCart(self)
        } else {
            categoriesArray = (defaults.array(forKey: "categoriesArray") as! [[String]])
        }
        if let ca = categoriesArray {
            for array in ca {
                !array.isEmpty ? initialAlert = false : nil
            }
        }
        initialAlert ? addToCart(self) : nil
        listTableView.bounces = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func addToCart(_ sender: Any) {
        alert = UIAlertController(title: "ADICIONAR ITEM AO CARRINHO", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = ""
            textField.inputView = self.pickerView
        }
        alert.addAction(UIAlertAction(title: "ADICIONAR", style: .default, handler: { (action: UIAlertAction!) in
            let textField = self.alert.textFields![0]
            if let tf = textField.text {
                if !tf.isEmpty {
                    self.categoriesArray?[self.selectedCategory.rawValue].append(tf)
                    self.defaults.set(self.categoriesArray, forKey: "categoriesArray")
                    self.defaults.synchronize()
                    self.listTableView.reloadData()
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Categories.allCases.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Categories(rawValue: section)?.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = categoriesArray?[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            categoriesArray?[indexPath.section].remove(at: indexPath.row)
            self.defaults.set(self.categoriesArray, forKey: "categoriesArray")
            self.defaults.synchronize()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Categories(rawValue: row)!
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Categories.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Categories(rawValue: row)?.name
    }
}
