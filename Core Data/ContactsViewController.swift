//
//  ContactsViewController.swift
//  Core Data
//
//  Created by Joshua Brooks on 11/4/19.
//  Copyright © 2019 Joshua Brooks. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        do {
            contacts = try managedContext.fetch(fetchRequest)
            
            contactsTableView.reloadData()
        } catch {
            print("Fetch could not be performed")
        }
    }

    @IBAction func addNewContact(_ sender: Any) {
        performSegue(withIdentifier: "showContact", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleContactViewController,
            let selectedRow = self.contactsTableView.indexPathForSelectedRow?.row else {
                return
        }
        destination.existingContact = contacts[selectedRow]
    }
    
    func deleteContact(at indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        if let managedContext = contact.managedObjectContext {
            managedContext.delete(contact)
            
            do {
                try managedContext.save()
                
                self.contacts.remove(at: indexPath.row)
                
                contactsTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Delete failed")
                
                contactsTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.first
        cell.detailTextLabel?.text = contact.last
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteContact(at: indexPath)
        }
    }
}
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showContact", sender: self)
    }
}
