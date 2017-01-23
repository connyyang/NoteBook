//
//  NoteDetailsViewController.swift
//  NoteBook
//
//  Created by Conny Yang on 23/01/2017.
//  Copyright © 2017 Conny Yang. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailsViewController: UIViewController {

    var note : Note?
    
    var managedObjectContext : NSManagedObjectContext!
    
    @IBOutlet weak var notePad: UITextView!
    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext

        navigationItem.rightBarButtonItem = doneButton
        
        if let note = note
        {
            notePad.text = note.noteText
        }
    }


    @IBAction func doneButtonDidTap(_ sender: Any) {
        
        if let note = note
        {
            
        }
        else
        {
            let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: managedObjectContext)
            let newNote = Note(entity: noteEntity!, insertInto: managedObjectContext)
            newNote.noteText = notePad.text
            newNote.updateTime = Date() as NSDate
            
            do{
                try self.managedObjectContext.save()
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
