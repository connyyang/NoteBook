//
//  NoteBookTableViewController.swift
//  NoteBook
//
//  Created by Conny Yang on 23/01/2017.
//  Copyright © 2017 Conny Yang. All rights reserved.
//

import UIKit
import CoreData

class NoteBookTableViewController: UITableViewController {
    
    var notes : [Note]?
    
    var managedObjectContent : NSManagedObjectContext!
    

    @IBOutlet weak var addButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Note Book"
        navigationItem.rightBarButtonItem = addButton
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContent = appDelegate.persistentContainer.viewContext
        
        fetchNotes()

    }
    
    struct StoryBoard{
        static let noteCell = "NoteCell"
        static let showNoteDetails = "ShowNoteDetails"
    }
    
    
    @IBAction func addNoteDidTap(_ sender: Any) {
        
        self.performSegue(withIdentifier: StoryBoard.showNoteDetails, sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchNotes()
    }
 
    
    func fetchNotes()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do{
            let noteObject = try self.managedObjectContent.fetch(fetchRequest) as! [Note]
            
            notes = noteObject
            
        }catch let error as NSError{
            print("Cannot fetch data: \(error.localizedDescription)")
        }
        
        self.tableView.reloadData()
    }
    
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let notes = notes else {
            return 0
        }
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.noteCell, for: indexPath)
        
        let note = self.notes?[indexPath.row]
        
        if let note = note
        {
            cell.textLabel?.text = note.noteText
            let updateTime = note.updateTime
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            let updateTimeString = dateFormat.string(from: updateTime as! Date)
            cell.detailTextLabel?.text = updateTimeString

        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let notes = notes
        {
            let note = notes[indexPath.row]
            self.performSegue(withIdentifier: StoryBoard.showNoteDetails, sender: note)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.showNoteDetails
        {
            let noteDetailsVC = segue.destination as! NoteDetailsViewController
            noteDetailsVC.note = sender as? Note
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
