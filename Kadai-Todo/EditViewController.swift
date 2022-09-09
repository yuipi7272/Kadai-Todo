//
//  EditViewController.swift
//  Kadai-Todo
//
//  Created by Yui Ogawa on 2022/09/09.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {

    var todo: Todo!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleTextField.text = todo.title
        contentTextView.text = todo.content
        datePicker.date = todo.date
    }
    @IBAction func save() {
        let title: String = titleTextField.text!
        let content: String = contentTextView.text!
        let date: Date = datePicker.date
        
        try! realm.write {
            todo!.title = title
            todo!.content = content
            todo!.date = date
        }
        let alert: UIAlertController = UIAlertController(title: "保存", message: "変更を保存しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    print("OKが押されました")
                    self.navigationController?.popToRootViewController(animated: true)
                })            
        )
        present(alert, animated: true, completion: nil)
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
