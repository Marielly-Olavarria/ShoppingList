//
//  ViewController.swift
//  ShoppingList
//
//  Created by Jonatan Ortiz on 21/02/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    var items: [String] = []
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        if items.isEmpty {
            addToCart(self)
        }
        self.navigationController?.navigationBar.prefersLargeTitles = true
        listTableView.bounces = false
    }
    
    @IBAction func addToCart(_ sender: Any) {
        alert = UIAlertController(title: "ADICIONAR ITEM AO CARRINHO", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "ADICIONAR", style: .default, handler: { (action: UIAlertAction!) in
            let textField = self.alert.textFields![0]
            if let tf = textField.text {
                if !tf.isEmpty {
                    self.items.append(tf)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
}
