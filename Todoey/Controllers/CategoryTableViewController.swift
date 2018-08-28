//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by JERUEL DE CASTRO on 05/07/2018.
//  Copyright © 2018 iHasMore. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    //1
    var categories = [Category]()
    //2
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //26
        loadCategories()
    }
    
    
    
    //MARK: - TableView Datasource Methods
    //3-4
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    //5-8
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    //21
    func saveCategories() {
        //23
        do {
            //22
            try context.save()
        } catch {
            //24
            print("Error saving categoty \(error)")
        }
        //25
        tableView.reloadData()
        
    }
    //27
    func loadCategories() {
        //28
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        //31
        do {
            //30         //29
            categories = try context.fetch(request)
        } catch {
            //32
            print("Error loading categories \(error)")
        }
        //33
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //13
        var textField = UITextField()
        
        //9
        let alert = UIAlertController(title: "Add New Category", message: "hey", preferredStyle: .alert)
        //10
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //17-20
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()

        }
        
        //11
        alert.addAction(action)
        
        //12
        alert.addTextField { (field) in
            //14-15
            textField = field
            textField.placeholder = "Create New Category"
        }
 
        //16
        present(alert, animated: true, completion: nil)
        
    }
    
 
    
   
}
