//
//  AddViewController.swift
//  Kadai-Todo
//
//  Created by Yui Ogawa on 2022/09/09.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save() {
        let title: String = titleTextField.text!
        let content: String = contentTextView.text!
        let date: Date = datePicker.date
        
        let newTodo = Todo()
        newTodo.title = title
        newTodo.content = content
        newTodo.date = date
        
        try! realm.write {
            realm.add(newTodo)
        }
        
        let alert: UIAlertController = UIAlertController(title: "保存", message: "保存が完了しました", preferredStyle: .alert)
        
        // OKボタン
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    print("OKが押されました！")
                    self.navigationController?.popViewController(animated: true)
                }
            )
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
